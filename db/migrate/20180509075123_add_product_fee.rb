class AddProductFee < ActiveRecord::Migration[5.1]
  def change
    add_column :products,:sqlx,:float,default: 1.0
    add_column :loan_messages,:bdmc,:string
    add_column :loan_messages,:bdlx,:string
  end
end
