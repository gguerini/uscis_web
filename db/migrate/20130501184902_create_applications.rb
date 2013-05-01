class CreateApplications < ActiveRecord::Migration
  def change
    create_table :applications do |t|
      t.string :number, null: false
      t.boolean :complete, null: false, default: false
      t.integer :user_id, null: false

      t.timestamps
    end

    add_index :applications, :number, unique: true
    add_index :applications, :user_id
  end
end
