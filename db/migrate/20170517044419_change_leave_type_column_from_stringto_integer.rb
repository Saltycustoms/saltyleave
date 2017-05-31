class ChangeLeaveTypeColumnFromStringtoInteger < ActiveRecord::Migration[5.0]
  def change
    change_column :leave_applications, :leave_type, :integer
  end
end
