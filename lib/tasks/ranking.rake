require 'utility/recipe_ranker'
require 'utility/ingredient_parser'

namespace :recipe_ranking do
  desc "sort and rank recipes"
  task :rank_all_movies do
    movies = Movie.all 
    movies.each do |movie|
      current_movie = Utility::RecipeRanker.new(movie)
      current_movie.create_all_movies_all_recipe_associations
    end
  end
end

namespace :ingredient_ranking do
  desc "sort and rank ingredients"
    task :rank_all_ingredients do
      u = Utility::IngredientParser.new
      u.populate_all_movies_ingredients_mentions
    end
  end
end