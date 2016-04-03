# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  title      :string           not null
#  url        :string
#  content    :text
#  hub_id     :integer          not null
#  author_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Post < ActiveRecord::Base

  validates :title, :hub_ids, presence: true

  belongs_to :author,
  foreign_key: :author_id,
  class_name: 'User'

  has_many :post_hubs,
  foreign_key: :post_id,
  class_name: 'PostHub'

  has_many :hubs,
  through: :post_hubs,
  source: :hub

  has_many :comments

  has_many :votes,
  as: :votable

  def comments_by_parent_id
    comment_hash = Hash.new([])
    self.comments.each do |comment|
      unless comment.is_top_level_comment?
        comment_hash[comment.parent_comment_id] += [comment]
      end
    end
    comment_hash
  end

  def vote_count
    self.votes.inject(0){|accum, vote| accum += vote.value}
  end

  def sorted_comments
    self.comments.sort{ |b,a| a.vote_count <=> b.vote_count }
  end

end
