# frozen_string_literal: true

require 'utility/imsdb_parser'

module Utility
  class ScriptScanner
    BLACKLISTED_WORDS_PATH = 'lib/utility/fixtures/blacklisted_words.json'
    OLD_PATH = BLACKLISTED_WORDS_PATH + '.old'
    NEW_PATH = BLACKLISTED_WORDS_PATH + '.new'

    attr_accessor :blacklisted_words, :searched_ingredients

    def initialize
      @blacklisted_words = fetch_blacklisted_words
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
      extract_all_ingredients_from_filtered_script(movie)
    end

    private

    def get_script(movie)
      parser = Utility::ImsdbParser.new
      parser.populate_script(movie) unless movie.is_scraped
    end

    def extract_all_ingredients_from_filtered_script(movie)
      words = JSON.parse(movie.filtered_script)
      words.each do |word|
        ingredient = @searched_ingredients[word] || Ingredient.find_by(name: word)
        next unless ingredient

        movie.ingredients << ingredient
        unless @searched_ingredients[word]
          @searched_ingredients[ingredient.name] = ingredient
        end
        puts "#{ingredient.name} associated to #{movie.title}"
      end
    end

    def filter_movie_script(movie)
      script = movie.script.split(' ')
      filtered_script = script.reject { |word| @blacklisted_words.include?(word) }
      movie.filtered_script = filtered_script
      movie.save
    end

    def fetch_blacklisted_words
      data = File.read(BLACKLISTED_WORDS_PATH)
      JSON.parse(data)
    end

    def update_blacklisted_words(blacklisted_words)
      File.rename(BLACKLISTED_WORDS_PATH, OLD_PATH)
      File.write(NEW_PATH, blacklisted_words)
      File.rename(NEW_PATH, BLACKLISTED_WORDS_PATH)
      File.delete(OLD_PATH)
    end
  end
end
