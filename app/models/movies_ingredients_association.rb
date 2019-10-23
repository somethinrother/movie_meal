class MoviesIngredientsAssociation < ApplicationRecord
  belongs_to :movie
  belongs_to :ingredient
end
