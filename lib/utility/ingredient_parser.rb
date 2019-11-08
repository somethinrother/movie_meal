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
      movie_ingredients.group_by(&:name).each do |_ingredient, mentions|
        metadata = parse_metadata_for_assocation(mentions, movie_ingredients)
        save_movie_ingredient_association_from_metadata(metadata)
      end
    end

    private

    def parse_metadata_for_assocation(mentions, movie_ingredients)
      mentions_count = mentions.length
      mentions_percentage = (mentions_count.to_f / movie_ingredients.length.to_f * 100).round(2)
      {
        movie: @movie,
        ingredient: mentions[0],
        mentions: mentions_count,
        mentions_percentage: mentions_percentage
      }
    end

    def save_movie_ingredient_association_from_metadata(metadata)
      movie_ingredient_association = MoviesIngredientsAssociation.new(metadata)
      movie_ingredient_association.save if movie_ingredient_association.valid?
    end
  end
end
