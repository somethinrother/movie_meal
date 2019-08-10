module Utility
  class RecipePuppyParser
    ALL_RECIPES_URL = 'http://www.recipepuppy.com/api/?q=&p='.freeze
    ALL_INGREDIENT_RECIPES_URL = 'http://www.recipepuppy.com/api/'.freeze

    def scrape_all_recipes
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

    def scrape_all_recipes_for(*ingredient)
      begin
        ing_search = ingredient.join('').gsub(/\s+/, "")
        recipes = {}
        100.times do |page|
          response = HTTParty.get("#{ALL_INGREDIENT_RECIPES_URL}?i=#{ing_search}&p=#{page + 1}")
          if response.success?
            parsed = JSON.parse(response)
            parsed["results"].each do |recipe|
              recipes[recipe["title"]] = recipe["ingredients"]
            end
          end
        end
        return recipes
      rescue JSON::ParserError
        puts "JSON::ParserError // API call failed"
        return recipes
      end
    end

    def get_one_recipe(*ingredient)
      begin
        ing_search = ingredient.join('').gsub(/\s+/, "")
        recipes = {}
        response = HTTParty.get("#{ALL_INGREDIENT_RECIPES_URL}?i=#{ing_search}&p=1")
        if response.success?
          parsed = JSON.parse(response)
          recipes[parsed["results"].first["title"]] = parsed["results"].first["ingredients"]
        return recipes
      end
      rescue JSON::ParserError
        puts "JSON::ParserError // API call failed"
        return recipesrecipe
      end
    end


  end
end
# Recipe.recipe_parser.get_one_recipe
# Recipe.recipe_parser.scrape_all_recipes
# Recipe.recipe_parser.scrape_all_recipes_for("garlic, onions")
