class ChangeLeaveDurationColumnFromStringtoInteger < ActiveRecord::Migration[5.0]
  def change
    change_column :leave_applications, :leave_duration, :integer
  end
end
