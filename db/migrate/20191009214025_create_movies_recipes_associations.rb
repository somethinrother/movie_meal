class CreateMoviesRecipesAssociations < ActiveRecord::Migration[5.2]
  def change
    create_table :movies_recipes_associations do |t|
      t.belongs_to :movie
      t.belongs_to :recipe
      t.integer :mentions
      t.string :ingredient_mentions
      t.decimal :mentions_percentage

      t.timestamps
    end
  end
end
