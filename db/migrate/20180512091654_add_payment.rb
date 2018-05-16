class AddPayment < ActiveRecord::Migration[5.1]
  def change
    create_table :payments do |t|
      t.boolean :payment_type
      t.float :balance
      t.integer :status
      t.string :no
      t.references :user
      t.string :category
      t.timestamps null: false
    end
  end
end
