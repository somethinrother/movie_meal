class IngredientMention < ApplicationRecord
	belongs_to :ingredients
	belongs_to :movies
end
