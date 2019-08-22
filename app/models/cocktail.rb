class Cocktail < ApplicationRecord
	validates :name, uniqueness: true
	has_many :ingredients
end
