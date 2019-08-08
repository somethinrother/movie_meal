class CreateMoviesRecipes < ActiveRecord::Migration[5.2]
  def change
    create_table :movies_recipes, id: false do |t|
      t.belongs_to :movie, index: true
      t.belongs_to :recipe, index: true
    end
  end
end
