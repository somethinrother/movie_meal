class Cocktail < ApplicationRecord
	validates :name, uniqueness: true
	has_and_belongs_to_many :ingredients
	has_and_belongs_to_many :movies
end
