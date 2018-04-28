class UpdateLoan < ActiveRecord::Migration[5.1]
  def change
    add_column :loans,:fwf,:float
    add_column :loans,:wzyj,:float
    add_column :loans,:bxyj,:float
    add_column :loans,:jkqx,:integer
    add_column :loans,:jkje,:float
    add_reference :loans,:product,index: true , foreign_key:true
    remove_column :loan_messages,:jkje
    remove_column :loan_messages,:jkqx
  end
end
