class CreateMoviesRecipes < ActiveRecord::Migration[5.2]
  def change
    create_table :movies_recipes do |t|
      t.belongs_to :movie
      t.belongs_to :recipe
      t.integer :mentions
      t.string :ingredient_mentions, array: true, default: [], using: "(string_to_array(ingredient_mentions, ','))"
      t.decimal :mentions_percentage

      t.timestamps
    end
  end
end
