class AddFilteredScriptToMovies < ActiveRecord::Migration[5.2]
  def change
    add_column :movies, :filtered_script, :text
  end
end
