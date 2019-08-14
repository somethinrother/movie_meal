require 'utility/recipe_puppy_parser'

class Recipe < ApplicationRecord
	validates :name, uniqueness: true
	has_and_belongs_to_many :movies
	has_and_belongs_to_many :ingredients
	def self.recipe_parser
		Utility::RecipePuppyParser.new
	end
end
