require 'utility/cocktail_parser'

class Cocktail < ApplicationRecord
	validates :name, uniqueness: true
	has_and_belongs_to_many :ingredients
	has_and_belongs_to_many :movies
	def self.cocktail_parser
		Utility::CocktailParser.new
	end
end
