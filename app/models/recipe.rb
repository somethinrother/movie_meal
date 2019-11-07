class Recipe < ApplicationRecord
	validates :name, uniqueness: true
	has_and_belongs_to_many :movies
	has_and_belongs_to_many :ingredients
	has_many :movies_recipes
	has_many :movies_recipes_associations
end
