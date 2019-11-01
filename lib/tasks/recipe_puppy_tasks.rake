require File.expand_path('../../../config/environment', __FILE__)
require 'utility/recipe_puppy_parser'
require 'utility/recipe_ranker'
require 'utility/ingredient_parser'

namespace :recipe_parser do
  desc "Scrape all recipes and ingredients from recipe puppy"
  task :scrape_all do
    parser = Utility::RecipePuppyParser.new
    parser.save_all_recipes_to_database
  end

  desc "Get Movies Recipe Associations"
  task :get_movies_recipes_associations do
    parser = Utility::RecipePuppyParser.new
    movies = Movie.all
    movies.each_slice(10) do |array_slice|
      Rake::Task["recipe_parser:scrape_slice_of_movies_array_for_recipes"].invoke(array_slice)
      Rake::Task["recipe_parser:scrape_slice_of_movies_array_for_recipes"].reenable
    end
  end

  task :scrape_slice_of_movies_array_for_recipes, [:array] do |task, args|
    slice_of_movies_array = args[:array]
    slice_of_movies_array.each do |movie|
      puts "Association for: #{movie.title}"
      parser = Utility::RecipeRanker.new(movie)
      parser.create_movie_recipes_associations
    end
  end

  desc "Get Movie Ingredients Associations"
  task :get_movies_ingredients_associations do
    movies = Movie.all
    movies.each_slice(10) do |array_slice|
      Rake::Task["recipe_parser:scrape_slice_of_movies_array_for_ingredients"].invoke(array_slice)
      Rake::Task["recipe_parser:scrape_slice_of_movies_array_for_ingredients"].reenable
    end
  end

  task :scrape_slice_of_movies_array_for_ingredients, [:array] do |task, args|
    slice_of_movies_array = args[:array]
    slice_of_movies_array.each do |movie|
      puts "scraping ingredients for #{movie.title}"
      parser = Utility::IngredientParser.new(movie)
      parser.create_movie_ingredients_associations
    end
  end

end
