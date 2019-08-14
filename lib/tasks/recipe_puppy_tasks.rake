require File.expand_path('../../../config/environment', __FILE__)
require 'utility/recipe_puppy_parser'

namespace :recipe_parser do
  desc "Scrape all recipes and ingredients from recipe puppy"
  task :scrape_all do
    Utility::RecipePuppyParser.new.save_all_recipes_to_database
  end

  desc "Query recipe from recipe puppy"
  task :query_recipe do
    Utility::RecipePuppyParser.new.query("Pasta Salad")
  end
end

namespace :database do
  desc "Drop and setup database locally"
  task :clear_and_setup do
    exec "rails db:drop && db:setup && db:migrate"
  end
end
