class CreateMoviesIngredientsAssociations < ActiveRecord::Migration[5.2]
  def up
    create_table :movies_ingredients_associations do |t|
      t.belongs_to :movie
      t.belongs_to :ingredient
      t.decimal :mentions
      t.decimal :mentions_percentage
      
      t.timestamps
    end
  end

  def down
    drop_table :movies_recipes_associations do |t|
    end
  end

end
