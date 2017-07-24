class AddSeparateLeaveDaysColumns < ActiveRecord::Migration[5.0]
  def change
    change_table :users do |t|
      t.integer :sick_days, default: 20
      t.integer :unpaid_days, default: 20
      t.rename :leave_days, :annual_days
    end
  end
end
