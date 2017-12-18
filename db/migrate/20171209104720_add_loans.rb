class AddLoans < ActiveRecord::Migration
  def change
    create_table :loans do |t|
      t.string :first_verify,default: "unverified"
      t.integer :verify_user
      t.string :customer_verify,default: "unverified"
      t.string :car_verify,default: "unverified"
      t.boolean :has_pay, default:false
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false

    end


    create_table :customer_messages do |t|
      t.string :status,default: "unverified"
      t.integer :verify_user
      t.references :loan, index: true, foreign_key: true

      t.timestamps null: false
    end
    create_table :car_messages do |t|
      t.string :status,default: "unverified"
      t.integer :verify_user
      t.references :loan, index: true, foreign_key: true

      t.timestamps null: false
    end

    create_table :loan_comments do |t|
      t.string :status,default: "unverified"
      t.integer :verify_user
      t.references :loan, index: true, foreign_key: true

      t.timestamps null: false
    end

    create_table :instalments do |t|
      t.float :balance
      t.integer :periods
      t.boolean :has_repay, default: false

      t.references :loan, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
