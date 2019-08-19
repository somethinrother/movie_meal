class CocktailsIngredients < ActiveRecord::Migration[5.2]
  def change
    create_table :cocktails_ingredients, id: false do |t|
      t.belongs_to :cocktails, index: true
      t.belongs_to :ingredients, index: true
    end
  end
end
