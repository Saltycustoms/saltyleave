class AddStatusToLeaveApplications < ActiveRecord::Migration[5.0]
  def change
    add_column :leave_applications, :status, :integer, default: 0
  end
end
