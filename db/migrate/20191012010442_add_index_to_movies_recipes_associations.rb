class AddIndexToMoviesRecipesAssociations < ActiveRecord::Migration[5.2]
  def change
    add_index :movies_recipes_associations, [:movie_id, :recipe_id], unique: true
  end
end
