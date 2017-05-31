class AddUserIdToLeaveApplication < ActiveRecord::Migration[5.0]
  def change
    add_column :leave_applications, :user_id, :integer
  end
end
