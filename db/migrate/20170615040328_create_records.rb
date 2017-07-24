class CreateRecords < ActiveRecord::Migration[5.0]
  def change
    create_table :records do |t|
      t.integer :user_id
      t.integer :leave_type_id
      t.integer :days

      t.timestamps
    end
  end
end
