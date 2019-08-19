class CocktailsMovies < ActiveRecord::Migration[5.2]
  def change
    create_table :cocktails_movies, id: false do |t|
      t.belongs_to :cocktails, index: true
      t.belongs_to :movies, index: true
    end
  end
end
