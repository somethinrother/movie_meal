# frozen_string_literal: true

module Utility
  class RecipeRanker
    attr_accessor :movie

    def initialize(movie)
      @movie = movie
    end

    def create_movie_recipes_associations
      movie_ingredients = @movie.ingredients
      recipes = Recipe.all
      recipes.each do |recipe|
        puts 'stuff'
        metadata = parse_metadata_for_assocation(recipe, movie_ingredients)
        next unless metadata

        save_movie_recipe_association_from_metadata(metadata)
      end
    end

    private

    def parse_metadata_for_assocation(recipe, movie_ingredients)
      shared_ingredients = (recipe.ingredients & movie_ingredients)
      return unless shared_ingredients.length > 1

      mentions = shared_ingredients.map(&:name)
      mentions_percentage = (shared_ingredients.length.to_f / movie_ingredients.length.to_f).to_f * 100
      {
        movie: @movie,
        recipe: recipe,
        mentions: mentions,
        mentions_percentage: mentions_percentage
      }
    end

    def save_movie_recipe_association_from_metadata(metadata)
      movie_recipe = MoviesRecipesAssociation.new(metadata)
      movie_recipe.save if movie_recipe.valid?
    end
  end
end
