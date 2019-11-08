# frozen_string_literal: true

require 'utility/imsdb_parser'

module Utility
  class ScriptScanner
    def get_scripts_for_movies_array(movies_by_character)
      movies_by_character.each do |movie|
        puts "got script for: #{movie.title}" if movie.is_scraped
        get_script(movie) unless movie.is_scraped
      end
    end

    def get_movies_by_character(character)
      puts "in get movies by character: #{character}"
      all_movies = Movie.all
      all_movies.select { |movie| movie.title[0].downcase == character.to_s }
    end

    def get_ingredients_from_script(movie)
      get_script(movie) unless movie.is_scraped
      return unless movie.is_scraped

      puts movie.title.to_s if movie.script
      extract_all_ingredients_from_script(movie)
    end

    private

    def get_script(movie)
      parser = Utility::ImsdbParser.new
      parser.populate_script(movie) unless movie.is_scraped
    end

    def extract_all_ingredients_from_script(movie)
      words = movie.script.split(' ')
      words.each do |word|
        ingredient = Ingredient.find_by(name: word)
        movie.ingredients << ingredient unless ingredient.nil?
        print "#{ingredient.name} " if movie.ingredients.include?(ingredient)
      end
    end
  end
end
