class DropJoinTableMoviesRecipes < ActiveRecord::Migration[5.2]
  def change
    drop_join_table :movies, :recipes
  end
end
