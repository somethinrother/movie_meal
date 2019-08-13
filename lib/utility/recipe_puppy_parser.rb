module Utility
  class RecipePuppyParser
    ALL_RECIPES_URL = 'http://www.recipepuppy.com/api/?q=&p='.freeze
    BASE_URL = 'http://www.recipepuppy.com/api/'.freeze

# Database query, quick and dirty
    def get_first_recipe_one_ingredient(ingredient)
      ingredient_with_recipes = Ingredient.find_by(name: ingredient )
      ingredient_with_recipes.recipes.first
    end

# API query, not a database query, need to add ingredient-recipe varification
    def query_all_recipes_for(*ingredients)
      ingredient_query = ingredients.join('').gsub(/\s+/, "")
      recipes = []
      100.times do |page|
        searched_url = "#{BASE_URL}?i=#{ingredient_query}&p=#{page + 1}"
        get_recipes(recipes, searched_url)
      end
    end

    def get_recipes(recipe_array, url)
      response = HTTParty.get(url)
      if response.success?
        parsed = JSON.parse(response)
        parsed["results"].each do |recipe|
          searched_recipe = Recipe.find_by(name: recipe["title"])
           if searched_recipe
            recipe_array << searched_recipe
          else
            recipe_array << Recipe.create(name: recipe["title"])
          end
        end
      end
      return recipe_array
    end

# Complete Scrape PARENT
    def save_all_recipes_to_database
      recipes = []
  		100.times do |page|
        url = "#{ALL_RECIPES_URL}#{page + 1}"
        get_recipes_to_save(recipes, url)
    	end
    end
# CHILD
    def get_recipes_to_save(recipe_array, url)
      response = HTTParty.get(url)
      if response.success?
        parsed = JSON.parse(response)
        parsed["results"].each do |recipe|
          recipe_ingredients = recipe["ingredients"].split(', ')
          check_recipes = Recipe.find_by(name: recipe["title"])
          if check_recipes
            process_ingredients_for_existing(check_recipes, recipe_ingredients)
          else
            new_recipe = Recipe.create({name: recipe["title"], thumbnail: recipe["thumbnail"]})
            process_ingredients_for_new(new_recipe, recipe_ingredients)
          end
        end
      end
    end
# CHILD
    def process_ingredients_for_existing(recipe, ingredients)
      ingredients.each do |ingredient|
        old_ingredient = Ingredient.find_by(name: ingredient )
        if old_ingredient
          recipe.ingredients << old_ingredient
        else
          recipe.ingredients << Ingredient.create({ name: ingredient })
        end
      end
    end
# CHILD
    def process_ingredients_for_new(recipe, ingredients)
      ingredients.each do |ingredient|
        old_ingredient = Ingredient.find_by(name: ingredient)
        if old_ingredient
          recipe.ingredients << old_ingredient
        elsif !(old_ingredient)
          recipe.ingredients << Ingredient.create({ name: ingredient })
        end
      end
    end
# # # # # # # # # # # #

  end
end



# TODO: Clean up recipe titles with regex, get rid of all \n\t\r

# def query_by_recipe(recipe)
#   begin
# recipe.
#   response = HTTParty.get("#{BASE_URL}#{recipe_words}")
#   # "?i=Pasta+with+Grilled+Shrimp+and+Pineapple+Salsa"
#   # search
#   rescue
# end



# QUICK LINKS FOR TESTING
# Recipe.recipe_parser.query_similar_recipes("Ginger Champagne")
# Recipe.recipe_parser.save_all_recipes_to_database
# Recipe.recipe_parser.get_first_recipe_one_ingredient("garlic")
# Recipe.recipe_parser.query_all_recipes_for("garlic, onions")
