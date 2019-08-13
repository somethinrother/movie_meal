module Utility
  class RecipePuppyParser
    ALL_RECIPES_URL = 'http://www.recipepuppy.com/api/?q=&p='.freeze
    BASE_URL = 'http://www.recipepuppy.com/api/'.freeze
# fix / update
    def query_all_recipes
      begin
        recipes = {}
        99.times do |page|
          response = HTTParty.get("#{ALL_RECIPES_URL}#{page + 1}")
          parsed = JSON.parse(response) if response.success?
          parsed["results"].each do |recipe|
            recipes[recipe["title"]] = recipe["ingredients"]
          end
        end
        return recipes
      rescue JSON::ParserError
        puts "JSON::ParserError // API call failed"
        return recipes
      end
    end
# fix / update
    def query_all_recipes_for(*ingredient)
      begin
        ing_search = ingredient.join('').gsub(/\s+/, "")
        recipes = {}
        100.times do |page|
          response = HTTParty.get("#{BASE_URL}?i=#{ing_search}&p=#{page + 1}")
          if response.success?
            parsed = JSON.parse(response)
            parsed["results"].each do |recipe|
    	        new_recipe = Recipe.create({ name: recipe["title"], thumbnail: recipe["thumbnail"]}) if recipe
              ingredient_array = recipe["ingredients"].split(', ')
              ingredient_array.each do |ingredient|
                new_ingredient = Ingredient.create({ name: ingredient })
                new_recipe.ingredients << new_ingredient if new_ingredient
              end
            end
          end
        end
        return recipes
      rescue JSON::ParserError
        puts "JSON::ParserError // API call failed"
      rescue ActiveRecord::RecordInvalid
        puts "Validation failed"
      end
    end



    def get_first_recipe_one_ingredient(ingredient)
      ingredient_with_recipes = Ingredient.find_by(name: ingredient )
  	  ingredient_with_recipes.recipes.first
    end

# refactor
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
