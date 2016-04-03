class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :post_id
      t.integer :parent_comment_id
      t.integer :author_id, null: false
      t.text :content, null: false
      t.timestamps null: false
    end
  end
end
