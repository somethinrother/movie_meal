class AddIndexToMoviesIngredientsAssociations < ActiveRecord::Migration[5.2]
  def change
    add_index :movies_ingredients_associations, [:movie_id, :ingredient_id], unique: true, :name => 'mov_ing_ass'
  end
end
