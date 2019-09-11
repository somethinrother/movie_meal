require 'utility/script_scanner'
require 'utility/imsdb_parser'

module Utility
  class RecipeRanker

    # Utility::RecipeRanker.search("Godfather")

    # If recipe is found for first ingredient, take that recipe and iterate over all the movie ingredients to see how many movie.ingredients that recipe contains, validating recipe for uniqueness
    def self.search(movie_search)
      movie = Movie.all.find_by(title: movie_search)
      if movie
        rank_recipes_by_ingredient_mentions(movie)
      else
        puts "There is no movie by those search terms"
      end
    end

    # movie IN, ranked recipes array based on ingredient_mentions OUT
    def self.rank_recipes_by_ingredient_mentions(movie)
      check_for_script_and_scrape_ingredients(movie) if movie.ingredients.length < 1
      recipes_array = []

      movie.ingredients.all.each do |ingredient|
        Recipe.all.each do |recipe|
          check_recipe_for_all_ingredient_mentions(recipes_array, recipe, movie, ingredient)
        end
      end
      recipes_array.sort_by { |recipe| recipe[:match_percentage] }.reverse
    end

    def self.check_recipe_for_all_ingredient_mentions(recipes_array, recipe, movie, ingredient)
      # if found_recipes don't include this recipe_obj, create found_recipe obj
      if !recipes_array.include?(recipe.name)
        recipe.ingredients.length > 1 ? create_recipe_obj_w_ing_mentions(recipes_array, recipe, movie, ingredient) : (print "No ingredients in #{recipe.name}")
      else
        puts "#{recipe.name}"
      end
      recipes_array
    end

    def self.create_recipe_obj_w_ing_mentions(recipes_array, recipe, movie, ingredient)
      return unless recipe.ingredients.find_by(name: ingredient.name)

      recipe_name = recipe.name.to_s
      recipe_name = {
        name: recipe.name,
        ingredients_mentioned: [ ingredient ],
        match_percentage: nil
      }
      movie.ingredients.all.each do |movie_ing|
        found_ingredient = recipe.ingredients.find_by(name: movie_ing.name)
        if !recipe_name[:ingredients_mentioned].include?(found_ingredient)
          recipe_name[:ingredients_mentioned] << found_ingredient
        end
      end
      calculate_percentage_of_recipe_ingredients_to_movie_ingredients(recipe_name, recipe, movie)
      recipes_array << recipe_name
    end

    def self.check_for_script_and_scrape_ingredients(movie)
      util = Utility::ScriptScanner.new
      util.get_script(movie) if !movie[:is_scraped]
      util.scan_script(movie)
    end

    def self.calculate_percentage_of_recipe_ingredients_to_movie_ingredients(recipe_object, recipe, movie)
      all_movie_ingredients = movie.ingredients.length.to_f
      ingredients_mentioned = recipe_object[:ingredients_mentioned].length.to_f
      percentage = (ingredients_mentioned / all_movie_ingredients).to_f * 100
      recipe_object[:match_percentage] = percentage
    end
  end
end
