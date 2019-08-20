module Utility
  class RecipePuppyParser
    BASE_URL = 'http://www.recipepuppy.com/api/'.freeze
    ALL_RECIPES_URL = 'http://www.recipepuppy.com/api/?q=&p='.freeze
    RECIPE_QUERY_BASE = 'http://www.recipepuppy.com/api/?q='.freeze
    MAX_PAGES = 100.freeze

    @recipes = []

    def query_for(recipe, number)
      recipe.gsub!(/\s/, '+')
      search(number).times do |page|
        searched_url = "#{RECIPE_QUERY_BASE}#{recipe}&p=#{page + 1}"
        get_recipes_to_query(recipe, searched_url)
      end
    end

    def query_all_recipes_for(*ingredients)
      ingredient_query_syntax = ingredients.join('').gsub(/\s+/, "")
      contact_recipe_api(ingredient_query_syntax, MAX_PAGES)
    end

    def contact_recipe_api(ingredient_query, number)
      search(number).times do |page|
        searched_url = "#{BASE_URL}?i=#{ingredient_query}&p=#{page + 1}"
        get_recipes_to_query(recipes, searched_url)
      end
      @recipes
    end

    def get_recipes_to_query(recipes_array, url)
      response = HTTParty.get(url)
      return JSON::ParserError unless response.success?

      parsed = JSON.parse(response)
      parsed["results"].each do |recipe|
        @recipes << organise_new_vs_old_recipe(recipe)
      end
    end

    def organise_new_vs_old_recipe(recipe)
      ingredients = recipe["ingredients"].split(', ')
      # Double check REGEX is working
      recipe_name = recipe["title"]
      recipe_name.gsub!(/[^0-9A-Za-z]/, ' ')
      check_recipe = Recipe.find_or_create_by(name: recipe_name, thumbnail: recipe["thumbnail"])
      process_ingredients_for(check_recipe, ingredients) if check_recipe
    end

    def process_ingredients_for(recipe, ingredients)
      ingredients.each do |ingredient|
        processing_ingredient = Ingredient.find_or_create_by(name: ingredient )
        recipe.ingredients << processing_ingredient if !(processing_ingredient)
      end
    end

    def save_all_recipes_to_database
      MAX_PAGES.times do |page|
        url = "#{ALL_RECIPES_URL}#{page + 1}"
        get_recipes_to_save(url)
    	end
    end

    def get_recipes_to_save(url)
      response = HTTParty.get(url)
      return JSON::ParserError unless response.success?

      parsed = JSON.parse(response)
      parsed["results"].each do |recipe|
        organise_new_vs_old_recipe(recipe)
      end
    end

    def search(number)
      number
    end

  end
end
