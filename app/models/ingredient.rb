class Ingredient < ApplicationRecord
  validates :name, uniqueness: true
  has_and_belongs_to_many :movies
  has_many :ingredient_mentions
  has_many :ingredients_recipes
end
