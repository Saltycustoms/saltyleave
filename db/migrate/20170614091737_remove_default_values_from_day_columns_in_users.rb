class RemoveDefaultValuesFromDayColumnsInUsers < ActiveRecord::Migration[5.0]
  def change
    change_column_default :users, :annual_days, from: 20, to: nil
    change_column_default :users, :sick_days, from: 20, to: nil
    change_column_default :users, :unpaid_days, from: 20, to: nil
  end
end
