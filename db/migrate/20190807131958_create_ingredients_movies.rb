class CreateIngredientsMovies < ActiveRecord::Migration[5.2]
  def change
    create_table :ingredients_movies, id: false do |t|
      t.belongs_to :ingredient, index: true
      t.belongs_to :movie, index: true
    end
  end
end
