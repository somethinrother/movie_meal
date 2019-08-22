require 'assets/cocktail_information'

module Utility
	class CocktailParser

		INGREDIENT_KEYS = %i[strIngredient1 strIngredient2 strIngredient3 strIngredient4 strIngredient5 strIngredient6 strIngredient7 strIngredient8 strIngredient9 strIngredient10 strIngredient11 strIngredient12 strIngredient13 strIngredient14 strIngredient15].freeze

		def save_cocktails
			DRINKS.each do |drink|
				cocktail = Cocktail.find_or_create_by(name: drink[:strDrink])
				ingredients = INGREDIENT_KEYS.map { |key| drink[key] }.reject { |ingredient| ingredient.nil? }
				ingredients.each do |ingredient|
					new_ingredient = Ingredient.find_or_create_by(name: ingredient)
					cocktail.ingredients << new_ingredient if !cocktail.ingredients.include?(new_ingredient)
				end
			end
		end

		def find_cocktail(name)
			Cocktail.find_by(name: name)
		end
# cannot do this without has_and_belongs_to_many association
		# def find_cocktail_by(*ingredients)
		# 	ingredients.each do |ingredient|
		# 		Ingredient.find_by(name: ingredient)
		# 	end
		# end

	end
end
