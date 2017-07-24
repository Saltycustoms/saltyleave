class RenameLeaveTypeToLeaveTypeIdInLeaveApps < ActiveRecord::Migration[5.0]
  def change
    change_table :leave_applications do |t|
      t.rename :leave_type, :leave_type_id
    end
  end
end
