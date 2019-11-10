# frozen_string_literal: true

require 'utility/imsdb_parser'

module Utility
  class ScriptScanner
    attr_accessor :non_ingredient_words, :searched_ingredients

    def initialize
      @non_ingredient_words = []
      @searched_ingredients = {}
    end

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
        next if @non_ingredient_words.include?(word)

        ingredient = @searched_ingredients[word]
        if ingredient
          movie.ingredients << ingredient
          puts "#{ingredient.name} associated to #{movie.title} from cache"
        else
          ingredient = Ingredient.find_by(name: word)

          if ingredient
            movie.ingredients << ingredient
            @searched_ingredients[ingredient.name] = ingredient 
            puts "#{ingredient.name} associated to #{movie.title} and added to cache"
          else
            @non_ingredient_words << word
            puts "#{word} is not an ingredient and has been blacklisted for the duration of this task"
          end
        end
      end
    end
  end
end
