class CreateCampTools < ActiveRecord::Migration[6.1]
  def change
    create_table :camp_tools do |t|
      t.string :tool_name,      null: false

      t.timestamps
    end
  end
end
