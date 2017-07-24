class RemoveMaxDaysColumnFromLeaveTypesTable < ActiveRecord::Migration[5.0]
  def change
    remove_column :leave_types, :max_days
  end
end
