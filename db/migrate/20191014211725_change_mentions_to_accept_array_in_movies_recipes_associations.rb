class ChangeMentionsToAcceptArrayInMoviesRecipesAssociations < ActiveRecord::Migration[5.2]
  def change
    change_column :movies_recipes_associations, :ingredient_mentions, :string, array: true, default: [], using: "(string_to_array(ingredient_mentions, ','))"
  end
end
