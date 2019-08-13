module Utility
  class RecipePuppyParser
    ALL_RECIPES_URL = 'http://www.recipepuppy.com/api/?q=&p='.freeze
    BASE_URL = 'http://www.recipepuppy.com/api/'.freeze

# API/db scrape/validation PARENT 1
    def query_all_recipes_for(*ingredients)
      ingredient_query_syntax = ingredients.join('').gsub(/\s+/, "")
      contact_recipe_api(ingredient_query_syntax)
    end

    def contact_recipe_api(ingredient_query)
      recipes = []
      100.times do |page|
        searched_url = "#{BASE_URL}?i=#{ingredient_query}&p=#{page + 1}"
        get_recipes(recipes, searched_url)
      end
      return recipes
    end

    def get_recipes_to_query(recipe_array, url)
      response = HTTParty.get(url)
      return error unless response.success?
        parsed = JSON.parse(response)
        parsed["results"].each do |recipe|
          organise_new_vs_old_recipes(recipe)
      end
      recipe_array
    end

    def organise_new_vs_old_recipes(results_recipe)
      recipe_ingredients = results_recipe["ingredients"].split(', ')
      # FIX, dont want to get rid of whitespace
      recipe_name_no_special_characters = results_recipe["title"].gsub!(/[^0-9A-Za-z]/, '')
      check_recipes = Recipe.find_by(name: recipe_name_no_special_characters)
        process_ingredients_for(check_recipes, recipe_ingredients) if check_recipes
      new_recipe = Recipe.create({name: recipe_name_no_special_characters, thumbnail: results_recipe["thumbnail"]})
        process_ingredients_for(new_recipe, recipe_ingredients) if new_recipe
    end

# Complete Scrape PARENT
    def save_all_recipes_to_database
      recipes = []
      100.times do |page|
        url = "#{ALL_RECIPES_URL}#{page + 1}"
        get_recipes_to_save(recipes, url)
    	end
    end

    def get_recipes_to_save(recipe_array, url)
      response = HTTParty.get(url)
      return error unless response.success?
      parsed = JSON.parse(response)
      parsed["results"].each do |recipe|
        organise_new_vs_old_recipes(recipe)
      end
    end

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
