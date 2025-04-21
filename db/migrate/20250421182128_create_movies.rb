class CreateMovies < ActiveRecord::Migration[7.1]
  def change
    create_table :movies do |t|
      t.string :title
      t.string :year
      t.integer :director_id
      t.text :description
      t.integer :duration
      t.string :image

      t.timestamps
    end
  end
end
