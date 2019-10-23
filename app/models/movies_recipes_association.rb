class MoviesRecipesAssociation < ApplicationRecord
  belongs_to :movie
  belongs_to :recipe
end
