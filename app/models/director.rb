# == Schema Information
#
# Table name: directors
#
#  id         :bigint           not null, primary key
#  bio        :text
#  dob        :datetime
#  image      :string
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Director < ApplicationRecord
  def self.with_dob
    where.not({ :dob => nil })
  end

  def self.youngest
    with_dob.order({ :dob => :desc }).at(0)
  end

  def self.eldest
    with_dob.order({ :dob => :asc }).at(0)
  end

  # def movies
  #   Movie.where({ :director_id => self.id })
  # end

  has_many :movies
end
