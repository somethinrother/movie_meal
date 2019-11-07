require 'utility/script_scanner'

module Utility
  class IngredientParser
    attr_accessor :movie

    def initialize(movie)
      @movie = movie
    end

    def create_movie_ingredients_associations
      begin
        movie_ingredients = @movie.ingredients
        
        movie_ingredients.each do |ingredient|
          mentions_count = movie_ingredients.select { |i| i.name === ingredient.name }.length
          
          movie_ingredient_association = MoviesIngredientsAssociation.new({movie: @movie, ingredient: ingredient, mentions: mentions_count, mentions_percentage: (mentions_count.to_f / movie_ingredients.length.to_f * 100).round(2) })
          movie_ingredient_association.save if movie_ingredient_association.valid?

          puts "#{ingredient.name} association created :)"
        end
      end
      rescue StandardError => msg
        puts msg
    end

  end
end