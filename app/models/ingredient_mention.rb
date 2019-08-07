class IngredientMention < ApplicationRecord
	validates :name, uniqueness: true
end
