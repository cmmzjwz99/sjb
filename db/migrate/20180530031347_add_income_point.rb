class AddIncomePoint < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :income_point, :float
    add_column :payments, :remark, :string
  end
end