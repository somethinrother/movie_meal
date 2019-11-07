class CreateMoviesRecipesAssociations < ActiveRecord::Migration[5.2]

  def up
    create_table :movies_recipes_associations do |t|
      t.belongs_to :movie
      t.belongs_to :recipe
      t.text :mentions, array: true, default: [], using: "(string_to_array(mentions, ','))"
      t.decimal :mentions_percentage

      t.timestamps
    end
  end

  def down
    drop_table :movies_recipes_associations do |t|
    end
  end
end
