class AddBankAddress < ActiveRecord::Migration[5.1]
  def change
    add_column :user_payments, :bank_address, :string
  end
end
