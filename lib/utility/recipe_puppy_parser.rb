module Utility
  class RecipePuppyParser
    ALL_RECIPES_URL = 'http://www.recipepuppy.com/api/?q=&p='.freeze
    BASE_URL = 'http://www.recipepuppy.com/api/'.freeze

# API query, not a database query
    def query_all_recipes_for(*ingredients)
      begin
        ing_search = ingredients.join('').gsub(/\s+/, "")
        recipes = []
        100.times do |page|
          response = HTTParty.get("#{BASE_URL}?i=#{ing_search}&p=#{page + 1}")
          if response.success?
            parsed = JSON.parse(response)
            parsed["results"].each do |recipe|
              searched_recipe = Recipe.find_by(name: recipe["title"])
              if searched_recipe
                recipes << searched_recipe
              end
            end
          end
        end
        recipes.each do |r|
          puts "Recipe: #{r.name}"
        end
      end
      rescue JSON::ParserError
        puts "JSON::ParserError // API call failed"
    end
# Database query
    def get_first_recipe_one_ingredient(ingredient)
      ingredient_with_recipes = Ingredient.find_by(name: ingredient )
  	  ingredient_with_recipes.recipes.first
    end
# Complete Scrape
    def save_all_recipes_to_database
    		100.times do |page|
    			response = HTTParty.get("#{ALL_RECIPES_URL}#{page + 1}")
    			if response.success?
    				parsed = JSON.parse(response)
    				parsed["results"].each do |recipe|
              recipe_ingredients = recipe["ingredients"].split(', ')
# CHECKING OLD RECIPE FOR MISSING INGREDIENTS
    					old_recipe = Recipe.find_by(name: recipe["title"])
    					if old_recipe
    						recipe_ingredients.each do |ingredient|
                  old_ingredient = Ingredient.find_by(name: ingredient )
                  if old_ingredient
                    old_recipe.ingredients << old_ingredient
                  else
    								old_recipe.ingredients << Ingredient.create({ name: ingredient })
      						end
                end
# CREATING NEW RECIPE AND CHECKING FOR OLD INGREDIENTS
    					else
    						new_recipe = Recipe.create({ name: recipe["title"], thumbnail: recipe["thumbnail"]})
    						recipe_ingredients.each do |ingredient|
    							old_ingredient = Ingredient.find_by(name: ingredient)
    							if old_ingredient
    								new_recipe.ingredients << old_ingredient
    							elsif !(old_ingredient)
    								new_recipe.ingredients << Ingredient.create({ name: ingredient })
    							end
    						end
    					end
    				end
    			end
    		end
    end



  end
end


# def query_by_recipe(recipe)
#   begin
# recipe.
#   response = HTTParty.get("#{BASE_URL}#{recipe_words}")
#   # "?i=Pasta+with+Grilled+Shrimp+and+Pineapple+Salsa"
#   # search
#   rescue
# end


# Have to find the original ingredient ID
# TODO: Clean up recipe titles with regex, get rid of all \n\t\r
# Recipe.recipe_parser.save_all_recipes_to_database
# Recipe.recipe_parser.get_first_recipe_one_ingredient("garlic")
# Recipe.recipe_parser.query_all_recipes_for("garlic, onions")
