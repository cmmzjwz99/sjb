class AddLoanImg < ActiveRecord::Migration[5.1]
  def change

    create_table :loan_images do |t|
      t.string :img
      t.string :style
      t.references :loan, index: true, foreign_key: true

      t.timestamps null: false
    end
    create_table :customer_images do |t|
      t.string :img
      t.string :style
      t.references :customer_message, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
