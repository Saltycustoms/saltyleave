class AddNumDaysColumnToUsersTable < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :leave_days, :integer, default: 20
  end
end
