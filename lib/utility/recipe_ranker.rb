require 'utility/script_scanner'
require 'utility/imsdb_parser'

module Utility
  class RecipeRanker
    attr_accessor :recipes, :movie

    def initialize(movie)
      @movie = movie
      @recipes = nil
    end

    def associate_all_recipes
      find_all_recipes_for_movie

      @recipes.each do |recipe|
        @movie.recipes << recipe
      end
    end

    def find_all_recipes_for_movie
      all_recipes = Recipe.all

      ingredients = @movie.ingredients
      @recipes = ingredients.each_with_object([]) do |ingredient, recipes|
        ingredient_name = ingredient.name
        
        recipes << all_recipes.select do |recipe|
          recipe_ingredients = recipe.ingredients.map { |ingredient| ingredient.name }
          
          recipe_ingredients.include?(ingredient_name)
        end
      end.flatten.uniq
    end
    
    def calculate_percentage_of_recipe_ingredients_in_movie_ingredients(recipe, movie)
      byebug
      movie_ingredients = @movie.ingredients

      recipe_ingredients = recipe.ingredients.map {|ingredient| 
      ingredient if movie_ingredients.find_by(name: ingredient.name) 
      }
      percentage = (recipe_ingredients.length.to_f / movie_ingredients.length.to_f) * 100
      percentage
    end

  end
end
