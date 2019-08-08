class CreateUsedIngredients < ActiveRecord::Migration[5.2]
  def change
    create_table :ingredients_recipes do |t|
      t.integer :ingredient_id
      t.integer :recipe_id
      t.timestamps
    end
  end
end
