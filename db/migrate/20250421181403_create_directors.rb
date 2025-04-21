class CreateDirectors < ActiveRecord::Migration[7.1]
  def change
    create_table :directors do |t|
      t.datetime :dob
      t.string :name
      t.string :image
      t.text :bio

      t.timestamps
    end
  end
end
