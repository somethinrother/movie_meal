class AddIndexToMoviesRecipes < ActiveRecord::Migration[5.2]
  def change
    add_index :movies_recipes, [:movie_id, :recipe_id], unique: true
  end
end
