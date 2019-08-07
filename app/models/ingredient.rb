class Ingredient < ApplicationRecord
  validates :name, uniqueness: true
  has_and_belongs_to_many :movies
end
