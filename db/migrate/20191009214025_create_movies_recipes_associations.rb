class CreateMoviesRecipesAssociations < ActiveRecord::Migration[5.2]
  def change
    create_table :movies_recipes_associations do |t|
      t.integer :movie_id
      t.integer :recipe_id
      t.integer :mentions
      t.string :ingredient_mentions
      t.decimal :mentions_percentage

      t.timestamps
    end
  end
end
