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
#  author_id   :bigint
#  director_id :integer
#
# Indexes
#
#  index_movies_on_author_id  (author_id)
#
# Foreign Keys
#
#  fk_rails_...  (author_id => users.id)
#
class Movie < ApplicationRecord
  include Likeable
  include Ransackable
  belongs_to :author, class_name: "User"
  belongs_to :director
  validates(:director_id, presence: true, numericality: { greater_than: 0 })

  def to_param
    "#{id}-#{title.parameterize}"
  end

  def to_s
    "#{title} (#{year})"
  end
end
