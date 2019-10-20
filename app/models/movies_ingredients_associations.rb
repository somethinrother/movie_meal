class MoviesIngredientsAssociations < ApplicationRecord
  belongs_to :movie
  belongs_to :ingredient
end
