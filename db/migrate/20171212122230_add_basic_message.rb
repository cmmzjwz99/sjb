class AddBasicMessage < ActiveRecord::Migration[5.1]
  def change
    create_table :basic_messages do |t|
      t.string :status,default: "verifyfail"
      t.integer :verify_user
      t.references :loan, index: true, foreign_key: true

      t.timestamps null: false
    end

    add_column :basic_messages, :company, :string
    add_column :basic_messages,:dkxs, :string
    add_column :basic_messages,:dklx, :string
    add_column :basic_messages,:dkqx, :string
    add_column :basic_messages,:dbfs, :string
    add_column :basic_messages,:dblx, :string
    add_column :basic_messages,:hkfs, :string
    add_column :basic_messages,:dkcp, :string
    add_column :basic_messages,:dkje, :string
    add_column :basic_messages,:lsed, :string
    add_column :basic_messages,:zjkje, :string
    add_column :basic_messages,:hkzl, :string
    add_column :basic_messages,:jkyt, :string
    add_column :basic_messages,:hkly, :string
    add_column :basic_messages,:dkqxdw, :string
    add_column :basic_messages,:ksrq, :datetime
    add_column :basic_messages,:jsrq, :datetime
    add_column :basic_messages,:zdr, :string
    add_column :basic_messages,:zdrq, :datetime
  end
end
