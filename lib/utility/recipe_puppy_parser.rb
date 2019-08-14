module Utility
  class RecipePuppyParser
    ALL_RECIPES_URL = 'http://www.recipepuppy.com/api/?q=&p='.freeze
    BASE_URL = 'http://www.recipepuppy.com/api/'.freeze

    def query_all_recipes_for(*ingredients)
      ingredient_query_syntax = ingredients.join('').gsub(/\s+/, "")
      contact_recipe_api(ingredient_query_syntax)
    end

    def contact_recipe_api(ingredient_query)
      recipes = []
      100.times do |page|
        searched_url = "#{BASE_URL}?i=#{ingredient_query}&p=#{page + 1}"
        get_recipes_to_query(recipes, searched_url)
      end
      recipes
    end

    def get_recipes_to_query(recipe_array, url)
      response = HTTParty.get(url)
      return JSON::ParserError 767 unless response.success?
      
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
      recipe_name.gsub!(/&quot/, '').gsub!(/[^0-9A-Za-z]/, ' ')
      check_recipes = Recipe.find_by(name: recipe_name)
      process_ingredients_for(check_recipes, ingredients) if check_recipes

      new_recipe_created = Recipe.create({name: recipe_name, thumbnail: results_recipe["thumbnail"]})
      process_ingredients_for(new_recipe_created, ingredients) if new_recipe_created
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

    def save_all_recipes_to_database
      100.times do |page|
        url = "#{ALL_RECIPES_URL}#{page + 1}"
        get_recipes_to_save(recipes, url)
    	end
    end

    def get_recipes_to_save(recipe_array, url)
      response = HTTParty.get(url)
      return JSON::ParserError 767 unless response.success?

      parsed = JSON.parse(response)
      parsed["results"].each do |recipe|
        organise_new_vs_old_recipes(recipe)
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
