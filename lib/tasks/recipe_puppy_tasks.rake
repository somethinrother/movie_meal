require File.expand_path('../../../config/environment', __FILE__)
require 'utility/recipe_puppy_parser'

namespace :recipe_parser do
  desc "Scrape all recipes and ingredients from recipe puppy"
  task :scrape_all do
    parser = Utility::RecipePuppyParser.new
    parser.save_all_recipes_to_database
  end
end
