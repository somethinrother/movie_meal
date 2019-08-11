module Utility
  class RecipePuppyParser
    ALL_RECIPES_URL = 'http://www.recipepuppy.com/api/?q=&p='.freeze
    ALL_INGREDIENT_RECIPES_URL = 'http://www.recipepuppy.com/api/'.freeze

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

    def query_all_recipes_for(*ingredient)
      begin
        ing_search = ingredient.join('').gsub(/\s+/, "")
        recipes = {}
        100.times do |page|
          response = HTTParty.get("#{ALL_INGREDIENT_RECIPES_URL}?i=#{ing_search}&p=#{page + 1}")
          if response.success?
            parsed = JSON.parse(response)
            parsed["results"].each do |recipe|
    	        new_recipe = Recipe.create({ name: recipe["title"], thumbnail: recipe["thumbnail"]}) if recipe
byebug
              ingredient_array = recipe["ingredients"].split(', ')
              ingredient_array.each do |ingredient|
                new_ingredient = Ingredient.create({ name: ingredient })
                new_recipe.ingredients.push(new_ingredient) if new_ingredient
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

    def get_first_recipe(*ingredient)
      begin
        recipe = {}
        ing_search = ingredient.join('').gsub(/\s+/, "")
        response = HTTParty.get("#{ALL_INGREDIENT_RECIPES_URL}?i=#{ing_search}&p=1")
        if response.success?
          parsed = JSON.parse(response)
          recipe = parsed["results"].first
            new_recipe = Recipe.create({ name: recipe["title"], thumbnail: recipe["thumbnail"]}) if recipe
            ingredient_array = recipe["ingredients"].split(', ')
              ingredient_array.each do |ingredient|
                new_ingredient = Ingredient.create({ name: ingredient })
                new_recipe.ingredients.push(new_ingredient) if new_ingredient
              end
        return recipe
      end
      rescue JSON::ParserError
        puts "JSON::ParserError // API call failed"
      rescue ActiveRecord::RecordInvalid
        puts "Validation failed"
      end
    end

    def save_all_recipes_to_database
      begin
        100.times do |page|
          response = HTTParty.get("#{ALL_INGREDIENT_RECIPES_URL}?q=&p=#{page + 1}")
          if response.success?
            parsed = JSON.parse(response)
            parsed["results"].each do |recipe|
    	        new_recipe = Recipe.create({ name: recipe["title"], thumbnail: recipe["thumbnail"]}) if recipe
              ingredient_array = recipe["ingredients"].split(', ')
              ingredient_array.each do |ingredient|
                new_ingredient = Ingredient.create({ name: ingredient })
                new_recipe.ingredients.push(new_ingredient) if new_ingredient
              end
            end
          end
        end
      end
      rescue JSON::ParserError
        puts "JSON::ParserError // API call failed"
      rescue ActiveRecord::RecordInvalid
        puts "Validation failed"
    end



  end
end

# TODO: Clean up recipe titles with regex, get rid of all \n\t\r
# Recipe.recipe_parser.save_all_recipes_to_database
# Recipe.recipe_parser.get_first_recipe("garlic")
# Recipe.recipe_parser.query_all_recipes_for("garlic, onions")
