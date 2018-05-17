class AddUserPayments < ActiveRecord::Migration[5.1]
  def change
    create_table :user_payments do |t|
      t.boolean :alipay_status
      t.string :alipay_qr
      t.string :alipay_name
      t.boolean :wechat_status
      t.string :wechat_qr
      t.string :wechat_name
      t.boolean :bank_status
      t.string :bank_no
      t.string :bank_name
      t.string :bank_user
      t.references :user
      t.timestamps null: false
    end
    add_column :users,:add_agent,:boolean,default: false
  end
end
