class AddRepaylogRemark < ActiveRecord::Migration[5.1]
  def change
    add_column :repay_logs,:remark,:string
    add_column :repay_logs,:verify_user_id,:integer
  end
end
