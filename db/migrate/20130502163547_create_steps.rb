class CreateSteps < ActiveRecord::Migration
  def change
    create_table :steps do |t|
      t.integer :application_id, null: false
      t.integer :status_id, null: false
      t.string :description
      t.string :more_info

      t.timestamps
    end

    add_index :steps, :application_id
    add_index :steps, [:application_id, :status_id], unique: true
  end
end
