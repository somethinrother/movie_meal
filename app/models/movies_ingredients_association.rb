class MoviesIngredientsAssociation < ApplicationRecord
  validates :ingredient, uniqueness: { scope: :movie }

  belongs_to :movie
  belongs_to :ingredient
end
