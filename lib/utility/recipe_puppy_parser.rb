module Utility
  class RecipePuppyParser
    ALL_RECIPES_URL = 'http://www.recipepuppy.com/api/?q=&p='.freeze
    RECIPE_QUERY_BASE = 'http://www.recipepuppy.com/api/?q='.freeze
    MAX_PAGES = 100.freeze

    def save_all_recipes_to_database
      MAX_PAGES.times do |page|
        url = "#{ALL_RECIPES_URL}#{page + 1}"
        query_for_recipes(url)
    	end
    end

    def get_recipes_to_query(recipes_array, url)
      response = HTTParty.get(url)
      return JSON::ParserError unless response.success?

      parsed = JSON.parse(response)
      parsed["results"].each do |recipe|
        create_new_recipe(recipe)
      end
    end

    def create_new_recipe(recipe_data)
      ingredients = recipe_data["ingredients"].split(', ')
      recipe_name = recipe_data["title"]
      recipe_name.gsub!(/[^0-9A-Za-z]/, ' ')
      recipe = Recipe.find_or_create_by(name: recipe_name, thumbnail: recipe_data["thumbnail"])
      associate_ingredients_to_recipe(recipe, ingredients) if recipe
    end

    def associate_ingredients_to_recipe(recipe, ingredients)
      ingredients.each do |ingredient_name|
        ingredient = Ingredient.find_or_create_by(name: ingredient_name)
        current_ingredients = recipe.ingredients
        current_ingredients << ingredient if !current_ingredients.include?(ingredient)
      end
    end

    def query_for_recipes(url)
      response = HTTParty.get(url)
      return JSON::ParserError unless response.success?

      parsed = JSON.parse(response)
      parsed["results"].each do |recipe|
        create_new_recipe(recipe)
      end
    end
  end
end
