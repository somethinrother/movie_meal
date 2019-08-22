class Ingredient < ApplicationRecord
  validates :name, uniqueness: true
  has_and_belongs_to_many :movies
  has_and_belongs_to_many :recipes
  has_and_belongs_to_many :cocktails
end
