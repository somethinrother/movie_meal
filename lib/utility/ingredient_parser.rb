module Utility
  class IngredientParser

    # generates list of ingredient objects ranked by mentions
    def rank_ingredients_by_ingredient_mentions(movie)
      ranked_ingredients_list = movie.ingredients.each_with_object(Hash.new(0)){ |m,h| h[m] += 1 }.sort_by{ |key,value| -value }

      prettier_ranked_list = []
      ranked_ingredients_list.each do |ingredient_object|
        ingredient_object[0] = "#{ingredient_object[0][:name]}"
        ingredient_object[1] = "#{ingredient_object[1]} total mentions"
        percentage_of_all_ingredient_mentions = (ingredient_object[1].to_f / movie.ingredients.length.to_f) * 100
        ingredient_object[2] = "#{percentage_of_all_ingredient_mentions}% vs. total" 
        prettier_ranked_list  << ingredient_object
      end
    end

  end
end