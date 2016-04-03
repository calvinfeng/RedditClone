class CreateHubs < ActiveRecord::Migration
  def change
    create_table :hubs do |t|
      t.string :title, null: false
      t.text :description, null: false
      t.integer :author_id, null: false
      t.timestamps null: false
    end
    add_index :hubs, :author_id
  end
end
