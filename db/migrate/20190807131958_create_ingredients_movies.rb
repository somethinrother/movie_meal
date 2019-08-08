class CreateIngredientsMovies < ActiveRecord::Migration[5.2]
  def change
    create_table :ingredients_movies, id: false do |t|
      t.belongs_to :movie_id, index: true
      t.belongs_to :ingredient_id, index: true
    end
  end
end
