class AddDayLimitToLeaveTypes < ActiveRecord::Migration[5.0]
  def change
    add_column :leave_types, :max_days, :integer
  end
end
