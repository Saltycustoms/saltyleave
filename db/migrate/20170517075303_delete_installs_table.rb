class DeleteInstallsTable < ActiveRecord::Migration[5.0]
  def up
    drop_table :installs if ActiveRecord::Base.connection.table_exists? :installs
  end

  def down
    create_table :installs unless ActiveRecord::Base.connection.table_exists? :installs
  end
end
