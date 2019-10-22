require 'utility/script_scanner'

module Utility
  class IngredientParser

    def populate_all_movies_ingredients_mentions
      begin
        all_movies = Movie.all
        all_movies.each do |movie|
          scan_script(movie) if !movie.ingredients
          create_movie_ingredients_associations(movie)
        end
      end
      rescue StandardError => msg
        puts msg
    end

    def create_movie_ingredients_associations(movie)
      ranked_ingredients_list = movie.ingredients.each_with_object(Hash.new(0)){ |m,h| h[m] += 1 }.sort_by{ |key,value| -value }
      
      ranked_ingredients_list.each do |ingredient_object|
        MoviesIngredientsAssociations.create(movie: movie, ingredient: ingredient_object[0], mentions: ingredient_object[1], mentions_percentage: ((ingredient_object[1].to_f / movie.ingredients.length.to_f) * 100).round(3))
        puts "#{ingredient_object} association created :)"
      end
    end
  end
end