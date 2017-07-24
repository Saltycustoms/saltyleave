class ChangeDepartmentFromStringToIntegerInUsersTable < ActiveRecord::Migration[5.0]
  def change
    change_column :users, :department, :integer
  end
end
