class CreateTags < ActiveRecord::Migration[6.1]
  def change
    create_table :tags do |t|
      t.string :tag,      null: false

      t.timestamps
    end

    add_index :tags,  :tag

  end
end
