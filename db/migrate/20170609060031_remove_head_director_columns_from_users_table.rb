class RemoveHeadDirectorColumnsFromUsersTable < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :is_head
    remove_column :users, :is_director
  end
end
