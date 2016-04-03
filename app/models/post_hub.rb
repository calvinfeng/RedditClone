class PostHub < ActiveRecord::Base
  validates :post_id, uniqueness: {scope: :hub_id}

  belongs_to :post,
  class_name: 'Post'

  belongs_to :hub,
  class_name: 'Hub'

end
