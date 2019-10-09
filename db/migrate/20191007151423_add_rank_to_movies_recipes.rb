class AddRankToMoviesRecipes < ActiveRecord::Migration[5.2]
  def change
    add_column :movies_recipes, :rank, :integer
    add_column :movies_recipes, :ingredient_mentions, :string
    add_column :movies_recipes, :mentions_percentage, :decimal
  end
end
