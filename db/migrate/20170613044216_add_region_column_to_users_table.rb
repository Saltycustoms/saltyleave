class AddRegionColumnToUsersTable < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :region, :integer
  end
end
