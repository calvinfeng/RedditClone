class CreatePostHubs < ActiveRecord::Migration
  def change
    create_table :post_hubs do |t|
      t.integer :post_id, null: false
      t.integer :hub_id, null: false
      t.timestamps null: false
    end
    add_index :post_hubs, [:post_id, :hub_id], unique: true

    remove_column :posts, :hub_id
  end
end
