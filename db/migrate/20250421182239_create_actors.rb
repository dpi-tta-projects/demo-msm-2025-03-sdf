class CreateActors < ActiveRecord::Migration[7.1]
  def change
    create_table :actors do |t|
      t.date :dob
      t.string :name
      t.text :bio
      t.string :image

      t.timestamps
    end
  end
end
