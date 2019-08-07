class CreateIngredientMentions < ActiveRecord::Migration[5.2]
  def change
    create_table :ingredient_mentions do |t|
      t.integer :movie_id
      t.integer :ingredient_id
    end
  end
end
