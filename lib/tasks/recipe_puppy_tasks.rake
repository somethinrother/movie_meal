require File.expand_path('../../../config/environment', __FILE__)
require 'utility/recipe_puppy_parser'

namespace :recipes do
  desc "Scrape recipes, ingredients from recipe puppy"
  task :scrape_all do
    Utility::RecipePuppyParser.new.save_all_recipes_to_database
  end
end