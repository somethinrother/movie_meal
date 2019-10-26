require 'utility/ingredient_parser'

namespace :ingredient_scanner do
  desc "Populate movies.ingredients"
  task :populate_ingredients do
   scanner = Utility::IngredientParser.new
   scanner.populate_all_movies_ingredients_mentions
  end
end