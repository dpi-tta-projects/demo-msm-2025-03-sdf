# == Schema Information
#
# Table name: movies
#
#  id          :bigint           not null, primary key
#  description :text
#  duration    :integer
#  image       :string
#  title       :string
#  year        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  director_id :integer
#
class Movie < ApplicationRecord

  # def director
  #   Director.where({ :id => self.director_id }).at(0)
  # end

  belongs_to :director
end
