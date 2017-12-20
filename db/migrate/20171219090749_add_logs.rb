class AddLogs < ActiveRecord::Migration[5.1]
  def change
    add_column :instalments,:repay_user_id,:integer
    add_column :user_powers,:repay_time,:datetime
    add_column :loans,:pay_time,:datetime
    add_column :loans,:pay_user_id,:integer
    add_column :loans,:verify_time,:datetime
    add_column :basic_messages,:verify_time,:datetime
    add_column :car_messages,:verify_time,:datetime
    add_column :customer_messages,:verify_time,:datetime
  end
end
