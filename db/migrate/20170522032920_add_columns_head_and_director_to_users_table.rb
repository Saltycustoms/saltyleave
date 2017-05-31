class AddColumnsHeadAndDirectorToUsersTable < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :is_head, :boolean
    add_column :users, :is_director, :boolean
  end
end
