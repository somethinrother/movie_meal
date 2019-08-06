class Ingredient < ApplicationRecord
  validates :name, uniqueness: true
end
