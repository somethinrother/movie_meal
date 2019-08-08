class Movie < ApplicationRecord
  validates :title, uniqueness: true
  has_and_belongs_to_many :ingredients
  has_and_belongs_to_many :recipes
  has_many :ingredients_movies
end
