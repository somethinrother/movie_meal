# frozen_string_literal: true

module Utility
  class RecipePuppyParser
    ALL_RECIPES_URL = 'http://www.recipepuppy.com/api/?q=&p='
    RECIPE_QUERY_BASE = 'http://www.recipepuppy.com/api/?q='
    MAX_PAGES = 100

    def save_all_recipes_to_database
      MAX_PAGES.times do |page|
        url = "#{ALL_RECIPES_URL}#{page + 1}"
        query_for_recipes(url)
      end
    end

    private

    def create_new_recipe(recipe_data)
      ingredients = recipe_data['ingredients'].split(', ')
      recipe_name = recipe_data['title']
      recipe_name.gsub!(/[^0-9A-Za-z]/, ' ')
      recipe = Recipe.find_or_create_by(name: recipe_name, thumbnail: recipe_data['thumbnail'])
      puts "#{recipe.name} created!"
      associate_ingredients_to_recipe(recipe, ingredients) if recipe
    end

    def associate_ingredients_to_recipe(recipe, ingredients)
      ingredients.each do |ingredient_name|
        ingredient = Ingredient.find_or_create_by(name: ingredient_name)
        current_ingredients = recipe.ingredients
        current_ingredients << ingredient unless current_ingredients.include?(ingredient)
      end
    end

    def query_for_recipes(url)
      response = HTTParty.get(url)
      return JSON::ParserError unless response.success?

      parsed = JSON.parse(response)
      parsed['results'].each do |recipe|
        create_new_recipe(recipe)
      end
    end
  end
end
