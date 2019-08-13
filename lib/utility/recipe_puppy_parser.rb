module Utility
  class RecipePuppyParser
    ALL_RECIPES_URL = 'http://www.recipepuppy.com/api/?q=&p='.freeze
    BASE_URL = 'http://www.recipepuppy.com/api/'.freeze

# API/db scrape/validation PARENT 1
    def query_all_recipes_for(*ingredients)
      ingredient_query_syntax = ingredients.join('').gsub(/\s+/, "")
      contact_recipe_api(ingredient_query_syntax)
    end
# CHILD 1
    def contact_recipe_api(ingredient_query)
      recipes = []
      100.times do |page|
        searched_url = "#{BASE_URL}?i=#{ingredient_query}&p=#{page + 1}"
        get_recipes(recipes, searched_url)
      end
      return recipes
    end
# CHILD 1
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

# Complete Scrape PARENT 2
    def save_all_recipes_to_database
      recipes = []
  		100.times do |page|
        url = "#{ALL_RECIPES_URL}#{page + 1}"
        get_recipes_to_save(recipes, url)
    	end
    end
# CHILD 2 I could probably refactor this a bit more
    def get_recipes_to_save(recipe_array, url)
      response = HTTParty.get(url)
      if response.success?
        parsed = JSON.parse(response)
        parsed["results"].each do |recipe|
          recipe_ingredients = recipe["ingredients"].split(', ')
          check_recipes = Recipe.find_by(name: recipe["title"])
          process_ingredients_for(check_recipes, recipe_ingredients) if check_recipes
          next if check_recipes
          new_recipe = Recipe.create({name: recipe["title"], thumbnail: recipe["thumbnail"]})
          process_ingredients_for(new_recipe, recipe_ingredients) if new_recipe
          end
      end
    end
# CHILD 2
    def process_ingredients_for(recipe, ingredients)
      ingredients.each do |ingredient|
        if Ingredient.find_by(name: ingredient ) && !(recipe.ingredients.find_by(name: ingredient ))
          recipe.ingredients << Ingredient.find_by(name: ingredient )
        elsif !(Ingredient.find_by(name: ingredient ))
          new_ingredient = Ingredient.create({ name: ingredient })
          recipe.ingredients << new_ingredient
        end
      end
    end

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
