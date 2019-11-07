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
      Rake::Task["recipe_parser:scrape_slice_of_movies_array"].invoke(array_slice)
      Rake::Task["recipe_parser:scrape_slice_of_movies_array"].reenable
    end
  end

  task :scrape_slice_of_movies_array, [:array] do |task, args|
    parser = Utility::RecipeRanker.new
    slice_of_movies_array = args[:array]
    slice_of_movies_array.each do |movie|
      puts "#{movie}"
      parser.create_movie_recipes_associations(movie)
    end
  end
end
