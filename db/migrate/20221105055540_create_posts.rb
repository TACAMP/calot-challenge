class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.integer :user_id,         null: false
      t.string :title,           null: false
      t.text :description
      t.string :campsite_name
      t.text :campsite_address
      t.timestamps
    end

    add_index :posts, :title

  end
end
