class IngredientMention < ApplicationRecord
	validates :id, uniqueness: true
end
