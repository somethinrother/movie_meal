# frozen_string_literal: true

require 'utility/script_scanner'

module Utility
  class IngredientParser
    attr_accessor :movie

    def initialize(movie)
      @movie = movie
    end

    def create_movie_ingredients_associations
      movie_ingredients = @movie.ingredients
      movie_ingredients.each do |ingredient|
        generate_ingredient_metadata_for_movie(ingredient)
      end
    rescue StandardError => e
      puts e
    end

    private

    def generate_ingredient_metadata_for_movie(ingredient)
      mentions_count = movie_ingredients.where(name: ingredient.name).length
      mentions_percentage = (mentions_count.to_f / movie_ingredients.length.to_f * 100).round(2)
      movie_ingredient_association = MoviesIngredientsAssociation.new(
        movie: @movie,
        ingredient: ingredient,
        mentions: mentions_count,
        mentions_percentage: mentions_percentage
      )
      movie_ingredient_association.save if movie_ingredient_association.valid?
    end
  end
end
