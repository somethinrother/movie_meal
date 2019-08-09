class Movie < ApplicationRecord
  validates :title, uniqueness: true, presence: true
  has_and_belongs_to_many :ingredients
  has_and_belongs_to_many :recipes
end
