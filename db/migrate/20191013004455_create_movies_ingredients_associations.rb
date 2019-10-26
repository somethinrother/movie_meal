class CreateMoviesIngredientsAssociations < ActiveRecord::Migration[5.2]
  def change
    create_table :movies_ingredients_associations do |t|
      t.belongs_to :movie
      t.belongs_to :ingredient
      t.text :mentions, array: true, default: []
      t.decimal :mentions_percentage
      
      t.timestamps
    end
  end
end
