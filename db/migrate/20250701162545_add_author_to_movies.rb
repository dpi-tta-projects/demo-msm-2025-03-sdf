class AddAuthorToMovies < ActiveRecord::Migration[7.1]
  def change
    add_reference :movies, :author, foreign_key: { to_table: :users }
  end
end
