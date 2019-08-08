class CreateIngredientsRecipes < ActiveRecord::Migration[5.2]
  def change
    create_table :ingredients_recipes, id: false do |t|
      t.belongs_to :ingredient_id, index: true
      t.belongs_to :recipe_id, index: true
    end
  end
end
