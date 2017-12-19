class AddPower < ActiveRecord::Migration[5.1]
  def change
    add_column :user_powers,:totle_loan,:boolean, default: false
  end
end
