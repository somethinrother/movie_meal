class MoviesRecipesAssociation < ApplicationRecord
  validates :recipe, uniqueness: { scope: :movie }

  belongs_to :movie
  belongs_to :recipe
end
