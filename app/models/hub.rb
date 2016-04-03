# == Schema Information
#
# Table name: hubs
#
#  id          :integer          not null, primary key
#  title       :string           not null
#  description :text             not null
#  author_id   :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Hub < ActiveRecord::Base
  validates :title, :description, :author_id, presence: true

  belongs_to :author,
  foreign_key: :author_id,
  class_name: 'User'

  has_many :post_hubs, dependent: :destroy,
  foreign_key: :hub_id,
  class_name: 'PostHub'

  has_many :posts,
  through: :post_hubs,
  source: :post

  def sorted_posts
     self.posts.sort{ |b,a| a.vote_count <=> b.vote_count }
  end
end
