module Utility
  class RecipePuppyParser
    BASE_URL = 'http://www.recipepuppy.com/api/'.freeze
    ALL_RECIPES_URL = 'http://www.recipepuppy.com/api/?q=&p='.freeze
    RECIPE_QUERY_BASE = 'http://www.recipepuppy.com/api/?q='.freeze
    MAX_PAGES = 100.freeze

    def query_for(recipe)
      recipe.gsub!(/\s/, '+')
      MAX_PAGES.times do |page|
        searched_url = "#{RECIPE_QUERY_BASE}#{recipe}&p=#{page + 1}"
        get_recipes_to_query(recipe, searched_url)
      end
    end

    def query_all_recipes_for(*ingredients)
      ingredient_query_syntax = ingredients.join('').gsub(/\s+/, "")
      contact_recipe_api(ingredient_query_syntax)
    end

    def contact_recipe_api(ingredient_query)
      recipes = []
      MAX_PAGES.times do |page|
        searched_url = "#{BASE_URL}?i=#{ingredient_query}&p=#{page + 1}"
        get_recipes_to_query(recipes, searched_url)
      end
      recipes
    end

    def get_recipes_to_query(recipe_array, url)
      response = HTTParty.get(url)
      return JSON::ParserError unless response.success?

      parsed = JSON.parse(response)
      parsed["results"].each do |recipe|
        organise_new_vs_old_recipes(recipe)
      end
      recipe_array
    end

    def organise_new_vs_old_recipes(results_recipe)
      ingredients = results_recipe["ingredients"].split(', ')
      # Double check REGEX is working
      recipe_name = results_recipe["title"]
      recipe_name.gsub!(/[^0-9A-Za-z]/, ' ')
      check_recipes = Recipe.find_or_create_by(name: recipe_name, thumbnail: results_recipe["thumbnail"])
      process_ingredients_for(check_recipes, ingredients) if check_recipes
    end

    def process_ingredients_for(recipe, ingredients)
      ingredients.each do |ingredient|
        if Ingredient.find_by(name: ingredient ) && !(recipe.ingredients.find_by(name: ingredient ))
          recipe.ingredients << Ingredient.find_or_create_by(name: ingredient )
        end
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
        organise_new_vs_old_recipes(recipe)
      end
    end

# IDENTIFYING A RECIPE FROM INGREDIENTS
    def check_database_for(query)
      if test
# IN PROGRESS RIGHT NOW JAMES
      end
    end

  end
end

# QUICK LINKS FOR TESTING
# Recipe.recipe_parser.query_for("Ginger Champagne")
# Recipe.recipe_parser.query_similar_recipes("Ginger Champagne")
# Recipe.recipe_parser.save_all_recipes_to_database
# Recipe.recipe_parser.get_first_recipe_one_ingredient("garlic")
# Recipe.recipe_parser.query_all_recipes_for("garlic, onions")
