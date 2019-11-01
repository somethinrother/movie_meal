require File.expand_path('../../../config/environment', __FILE__)
require 'utility/recipe_puppy_parser'

namespace :recipe_parser do
  desc "Scrape all recipes and ingredients from recipe puppy"
  task :scrape_all do
    parser = Utility::RecipePuppyParser.new
    parser.save_all_recipes_to_database
  end

  desc "Get Movie Recipe Associations"
  task :get_movies_recipes_associations do
    parser = Utility::RecipePuppyParser.new
    movies = Movie.all
    movies.each_slice(10) do |array_slice|
      Rake::Task["script_scanner:scrape_slice_of_movies_array_for_recipes"].invoke(array_slice)
      Rake::Task["script_scanner:scrape_slice_of_movies_array_for_recipes"].reenable
    end
  end

  task :scrape_slice_of_movies_array_for_recipes, [:array] do |task, args|
    parser = Utility::RecipePuppyParser.new
    slice_of_movies_array = args[:array]
    slice_of_movies_array.each do |movie|
      puts "#{movie}"
      parser.create_movie_recipes_associations(movie)
    end
  end

  desc "Get Movie Ingredients Associations"
  task :get_movies_ingredients_associations do
    parser = Utility::RecipePuppyParser.new
    movies = Movie.all
    movies.each_slice(10) do |array_slice|
      Rake::Task["script_scanner:scrape_slice_of_movies_array_for_ingredients"].invoke(array_slice)
      Rake::Task["script_scanner:scrape_slice_of_movies_array_for_ingredients"].reenable
    end
  end

  task :scrape_slice_of_movies_array_for_ingredients, [:array] do |task, args|
    parser = Utility::RecipePuppyParser.new
    slice_of_movies_array = args[:array]
    slice_of_movies_array.each do |movie|
      puts "#{movie}"
      parser.create_movie_ingredients_associations(movie)
    end
  end

end
