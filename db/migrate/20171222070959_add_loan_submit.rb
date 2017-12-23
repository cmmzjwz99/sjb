class AddLoanSubmit < ActiveRecord::Migration[5.1]
  def change
    add_column :loans,:first_submit,:boolean,default: false
    add_column :loans,:basic_submit,:boolean,default: false
    add_column :loans,:customer_submit,:boolean,default: false
    add_column :loans,:car_submit,:boolean,default: false
  end
end
