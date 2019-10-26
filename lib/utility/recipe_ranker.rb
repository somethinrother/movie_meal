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
      # begin
      #   all_recipes = Recipe.all
      #   movie_ingredients = @movie.ingredients

      # # get the movie's recipes, unvetted
      #   @recipes = movie_ingredients.each_with_object([]) do |ingredient, recipes|
      #     ingredient_name = ingredient.name
          
      #     recipes << all_recipes.select do |recipe|
      #       recipe_ingredients = recipe.ingredients.map { |ingredient| ingredient.name }
      
      #       recipe_ingredients.include?(ingredient_name)
      #     end
      #   end.flatten.uniq
        
      # # vet recipes, drop those with only one ingredient mention
      #   @recipes.each do |recipe|
      #     found_ingredients = []
      #     recipe.ingredients.each do |ingredient|
      #       found_ingredients << ingredient.name if movie_ingredients.find_by(name: ingredient.name)
      #     end
      #     # if recipe passes vetting, create an entry for the association in M_R_A
      #     if found_ingredients.length > 1
      #       entry = MoviesRecipesAssociation.create(recipe: recipe, movie: movie, mentions: found_ingredients.length, ingredient_mentions: found_ingredients, mentions_percentage: (( found_ingredients.length.to_f / movie_ingredients.length.to_f) * 100))
      #       puts "#{entry.movie.name} recipes and ingredients added"
      #     else
      #       puts 'nothing found bitch'
      #     end
      #   end
      # rescue ValidationError => error
      #   puts error
      # end

      movie_ingredients = @movie.ingredients
      recipes = Recipe.all

      recipes.each do |recipe|
        recipe_ingredients = recipe.ingredients
        
        if ((movie_ingredients | recipe_ingredients).uniq.length > 2)

          # Find out if the recipe shares more than one ingredient with movie.ingredients
          @movie.recipes << recipe unless @movie.recipes.include?(recipe)
          puts "MOVIE ID:#{movie.id}. TITLE:#{movie.title}, RECIPE: #{recipe.name}"
          recipe.ingredients.each do |ingredient|
            if movie.ingredients.include?(ingredient)
              movie_ingredient = MoviesIngredientsAssociation.new({
                movie: @movie,
                ingredient: ingredient
              })
              
              movie_ingredient.save if movie_ingredient.valid?
            end
          end
        end
      end
    end
  end
end