class ChangeLeaveTypeToName < ActiveRecord::Migration[5.0]
  def change
    change_table :leave_types do |t|
      t.rename :leave_type, :name
    end
  end
end
