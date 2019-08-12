module Utility
  class RecipePuppyParser
    ALL_RECIPES_URL = 'http://www.recipepuppy.com/api/?q=&p='.freeze
    BASE_URL = 'http://www.recipepuppy.com/api/'.freeze
# fix
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
# fix
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
# fix
    def get_first_recipe(*ingredient)
      begin
        recipe = {}
        ing_search = ingredient.join('').gsub(/\s+/, "")
        response = HTTParty.get("#{BASE_URL}?i=#{ing_search}&p=1")
        if response.success?
          parsed = JSON.parse(response)
          recipe = parsed["results"].first
          new_recipe = Recipe.create({ name: recipe["title"], thumbnail: recipe["thumbnail"]}) if recipe
          ingredient_array = recipe["ingredients"].split(', ')
            ingredient_array.each do |ingredient|
              new_ingredient = Ingredient.new({ name: ingredient })
              if new_ingredient.valid?
                new_ingredient.save
                new_recipe.ingredients << new_ingredient
              else
                all_ingredients = Ingredient.all
                old_ingredient = all_ingredients.find_by_sql("SELECT * FROM ingredients WHERE name = '#{new_ingredient.name}'")
                new_recipe.ingredients << old_ingredient
                puts "existing ingredient attached to new recipe"
              end
            end
        end
        return recipe
      rescue ActiveRecord::RecordInvalid
        puts "Validation failed"
      rescue JSON::ParserError
        puts "JSON::ParserError // API call failed"
      end
    end

    def save_all_recipes_to_database
      begin
        100.times do |page|
          response = HTTParty.get("#{ALL_RECIPES_URL}#{page + 1}")
          if response.success?
            parsed = JSON.parse(response)
            parsed["results"].each do |recipe|
              new_recipe = Recipe.new({ name: recipe["title"], thumbnail: recipe["thumbnail"]})
# NEW RECIPE METHOD
              if new_recipe.valid?
                new_recipe.save
                ingredient_array = recipe["ingredients"].split(', ')
                ingredient_array.each do |ingredient|
                  new_ingredient = Ingredient.new({ name: ingredient })
                  if new_ingredient.valid?
                    new_ingredient.save
                    new_recipe.ingredients << new_ingredient
                    puts "new ingredient attached to a new recipe"
                  elsif new_ingredient.invalid?
                    new_recipe.ingredients << Ingredient.find_by(name: new_ingredient.name)
                    puts "existing ingredient attached to a new recipe"
                  end
                end
# EXISTING RECIPE METHOD
                elsif new_recipe.invalid?
                old_recipe = Recipe.find_by(name: new_recipe.name)
                ingredient_array = recipe["ingredients"].split(', ')
                ingredient_array.each do |ingredient|
                  new_ingredient = Ingredient.new({ name: ingredient })
    # INGREDIENT VALIDATION, checking db, creating recipe/ingredient link
                  if new_ingredient.valid?
                    new_ingredient.save
                    old_recipe.ingredients << new_ingredient
                    puts "recipe exists in the database with no ingredients, new ingredient attached to that recipe"
                  elsif new_ingredient.invalid?
                    unless old_recipe.ingredients.find_by(name: new_ingredient.name)
                    old_recipe.ingredients << Ingredient.find_by(name: new_ingredient.name)
                    puts "recipe exists in the database with no ingredients, existing ingredient attached to that recipe"
                    end
                  end
                end
# EXISTING RECIPE FULLY COMPLETE
              elsif new_recipe.invalid?
                puts "recipe exists in the database, has ingredients"
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
# Recipe.recipe_parser.get_first_recipe("garlic")
# Recipe.recipe_parser.query_all_recipes_for("garlic, onions")
