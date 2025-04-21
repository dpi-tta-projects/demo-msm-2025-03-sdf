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
end
