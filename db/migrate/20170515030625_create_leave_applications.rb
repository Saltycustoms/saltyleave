class CreateLeaveApplications < ActiveRecord::Migration[5.0]
  def change
    create_table :leave_applications do |t|
      t.string :leave_type
      t.date :start_date
      t.date :end_date
      t.string :leave_duration
      t.string :reason

      t.timestamps
    end
  end
end
