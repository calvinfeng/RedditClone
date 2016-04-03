class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title, null: false
      t.string :url
      t.text :content
      t.integer :hub_id, null: false
      t.integer :author_id, null: false
      t.timestamps null: false
    end
    add_index :posts, :author_id
    add_index :posts, :hub_id
  end
end
