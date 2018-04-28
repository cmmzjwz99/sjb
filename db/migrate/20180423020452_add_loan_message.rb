class AddLoanMessage < ActiveRecord::Migration[5.1]
  def change
    create_table :loan_messages do |t|
      t.integer :jkje
      t.integer :jkqx
      t.string :jkxxyt
      t.string :htxlh
      t.string :xb
      t.string :nl
      t.string :yddh
      t.string :hyzk
      t.string :sfz
      t.string :xl
      t.string :zzdh
      t.string :hjxxdz
      t.string :xjdz
      t.string :qsjzsj
      t.string :gyqsrs
      t.string :fclb
      t.string :dwxz
      t.string :gzdw
      t.string :sshy
      t.string :zw
      t.string :qsgzsj
      t.string :dwdz
      t.string :dwdh
      t.string :jbsr
      t.string :qtsr
      t.string :zsr
      t.string :dwdh
      t.string :dwdh
      t.string :qs1
      t.string :qs1_gx
      t.string :qs1_dh
      t.string :qs2
      t.string :qs2_gx
      t.string :qs2_dh
      t.string :qs3
      t.string :qs3_gx
      t.string :qs3_dh
      t.references :loan, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
