class Movie < ApplicationRecord
  validates :title, uniqueness: true
  has_and_belongs_to_many :movies
  has_many :ingredient_mentions
end
