# == Schema Information
#
# Table name: characters
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  actor_id   :integer
#  movie_id   :integer
#
class Character < ApplicationRecord

  # def movie
  #   Movie.where({ :id => self.movie_id }).at(0)
  # end

  belongs_to :movie
  belongs_to :actor

  include PgSearch::Model
  multisearchable against: [:name]
end
