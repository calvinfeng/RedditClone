class Comment < ActiveRecord::Base
  validates :content, :author_id, presence: true

  belongs_to :author,
  foreign_key: :author_id,
  class_name: 'User'

  belongs_to :post,
  foreign_key: :post_id,
  class_name: 'Post'

  # if this is a nested comment, it will have a parent id
  belongs_to :comment,
  foreign_key: :parent_comment_id,
  class_name: 'Comment'

  has_many :child_comments,
  foreign_key: :parent_comment_id,
  class_name: 'Comment'

  has_many :votes,
  as: :votable

  def vote_count
    self.votes.inject(0){|accum, vote| accum += vote.value}
  end

  def is_top_level_comment?
    self.parent_comment_id.nil?
  end
end
