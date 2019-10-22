require 'utility/script_scanner'
require 'utility/imsdb_parser'

module Utility
  class RecipeRanker
    attr_accessor :recipes, :movie

    def initialize(movie)
      @movie = movie
      @recipes = nil
    end

    def create_movie_recipes_associations
      begin
        all_recipes = Recipe.all
        movie_ingredients = @movie.ingredients

      # get the movie's recipes, unvetted
        @recipes = movie_ingredients.each_with_object([]) do |ingredient, recipes|
          ingredient_name = ingredient.name
          
          recipes << all_recipes.select do |recipe|
            recipe_ingredients = recipe.ingredients.map { |ingredient| ingredient.name }
      
            recipe_ingredients.include?(ingredient_name)
          end
        end.flatten.uniq
        
      # vet recipes, drop those with only one ingredient mention
        @recipes.each do |recipe|
          found_ingredients = []
          recipe.ingredients.each do |ingredient|
            found_ingredients << ingredient.name if movie_ingredients.find_by(name: ingredient.name)
          end
          # if recipe passes vetting, create an entry for the association in M_R_A
          if found_ingredients.length > 1
            entry = MoviesRecipesAssociations.create(recipe: recipe, movie: movie, mentions: found_ingredients.length, ingredient_mentions: found_ingredients, mentions_percentage: (( found_ingredients.length.to_f / movie_ingredients.length.to_f) * 100))
            puts "#{entry.movie.name} recipes and ingredients added"
          end
          
        end
      rescue ValidationError => error
        puts error
      end
    end
  end
end