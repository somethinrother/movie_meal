class Recipe < ApplicationRecord
	validates :name, uniqueness: true
	has_and_belongs_to_many :movies
	has_and_belongs_to_many :ingredients
	has_many :used_ingredients
end
