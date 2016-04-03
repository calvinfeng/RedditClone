class AddIndexToPostId < ActiveRecord::Migration
  def change
    change_column_null :comments, :post_id, false
    add_index :comments, :post_id
    add_index :comments, :parent_comment_id
  end
end
