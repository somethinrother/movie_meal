# frozen_string_literal: true

require 'utility/script_scanner'

namespace :script_scanner do
  desc 'Populate scripts for all movies'
  task :populate_all_scripts do
    all_numbers = (1..9).to_a
    all_letters = ('a'..'z').to_a
    all_characters = all_numbers.concat(all_letters)

    all_characters.each do |character|
      Rake::Task['script_scanner:populate_scripts_for_movies_with_character'].invoke(character)
      Rake::Task['script_scanner:populate_scripts_for_movies_with_character'].reenable
    end
  end

  desc 'Populate scripts for movies_with_character'
  task :populate_scripts_for_movies_with_character, [:character] do |_task, args|
    puts 'task}'
    scanner = Utility::ScriptScanner.new
    movies_by_character = scanner.get_movies_by_character(args[:character])
    movies_by_character.each_slice(20) do |array_slice|
      Rake::Task['script_scanner:get_scripts_for_movies_array'].invoke(array_slice)
      Rake::Task['script_scanner:get_scripts_for_movies_array'].reenable
    end
  end

  task :get_scripts_for_movies_array, [:array] do |_task, args|
    scanner = Utility::ScriptScanner.new
    scanner.get_scripts_for_movies_array(args[:array])
  end

  desc 'Scrape Movie Script For Ingredients'
  task :get_all_ingredients, [:character] do |_task, _args|
    movies = Movie.all
    scanner = Utility::ScriptScanner.new
    movies.each do |movie|
      scanner.get_ingredients_from_script(movie)
    end
  end

  task :get_ingredients_from_scripts, [:array] do |task, args|
    puts task.to_s
    scanner = Utility::ScriptScanner.new
    movies = args[:array]
    movies.each do |movie|
      scanner.get_ingredients_from_script(movie)
    end
  end

  task :get_movie_ingredient_associations, [:array] do |task, args|
    puts task.to_s
    slice_of_movies = args[:array]
    scanner = Utility::ScriptScanner.new
    slice_of_movies.each do |movie|
      scanner.get_ingredients_from_script(movie)
    end
  end
end
