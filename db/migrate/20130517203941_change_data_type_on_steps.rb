class ChangeDataTypeOnSteps < ActiveRecord::Migration
  def change
    change_column :steps, :description, :text
    change_column :steps, :more_info, :text
  end
end
