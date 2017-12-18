class AddLoanMsg < ActiveRecord::Migration[5.1]
  def change
    remove_column :customer_messages,:balance
    add_column :car_messages, :pgrq, :datetime
    add_column :car_messages, :pgjz, :string
    add_column :car_messages, :qsr, :datetime
    add_column :car_messages, :zzr, :datetime
    add_column :car_messages, :cfdz, :string
    add_column :car_messages, :ypbz, :string
    add_column :car_messages, :ypdw, :string
    add_column :car_messages, :zdyl, :float
    add_column :car_messages, :kdjz, :float
    add_column :car_messages, :yyjz, :float
    add_column :car_messages, :ypsl, :integer
    add_column :car_messages, :dq, :string
    add_column :car_messages, :pgdw, :string
    add_column :car_messages, :pgry, :string
    add_column :car_messages, :ydgps, :integer
    add_column :car_messages, :gdgps, :integer
    add_column :car_messages, :clsbm, :string
    add_column :car_messages, :qcpp, :string
    add_column :car_messages, :qcxh, :string
    add_column :car_messages, :qbxhxx, :string
    add_column :car_messages, :csbs, :string
    add_column :car_messages, :spsj, :datetime
    add_column :car_messages, :ccrq, :datetime
    add_column :car_messages, :xsgl, :string
    add_column :car_messages, :clys, :string
    add_column :car_messages, :nsqk, :string
    add_column :car_messages, :qmqk, :string
    add_column :car_messages, :gkzk, :string
    add_column :car_messages, :ghcs, :string
    add_column :car_messages, :xtpgj, :float
    add_column :car_messages, :pjpgj, :float
    add_column :car_messages, :qcpz, :string
    add_column :car_messages, :fkfs, :string
    add_column :car_messages, :fdjhm, :string
    add_column :car_messages, :gcjk, :string
    add_column :car_messages, :gmsj, :datetime
    add_column :car_messages, :gmjg, :string
    add_column :car_messages, :synx, :string
    add_column :car_messages, :pl, :string



  end
end
