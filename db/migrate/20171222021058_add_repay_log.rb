class AddRepayLog < ActiveRecord::Migration[5.1]
  def change
    create_table :repay_logs do |t|
      t.string :no
      t.float :balance
      t.string :status,default: "unverified"
      t.references :instalment, index: true, foreign_key: true
      t.datetime :verify_time

      t.timestamps null: false

    end
  end
end
