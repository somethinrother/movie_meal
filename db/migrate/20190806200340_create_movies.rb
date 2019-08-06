class CreateMovies < ActiveRecord::Migration[5.2]
  def change
    create_table :movies do |t|
      t.string :title
      t.string :writers
			t.integer :year
		  t.boolean :is_scraped

      t.timestamps
    end
  end
end
