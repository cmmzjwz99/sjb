class AddPrice < ActiveRecord::Migration[5.1]
  def change
    remove_column :products, :ffw
    add_column :products, :bzj, :float ,default: 0
    add_column :products, :qt, :float ,default: 0
    add_column :products, :fxj, :float ,default: 0
    add_column :basic_messages, :fwf, :float ,default: 0
    add_column :basic_messages, :wzyj, :float ,default: 0
    add_column :basic_messages, :bxyj, :float ,default: 0

    add_column :instalments, :wzyj, :float ,default: 0
    add_column :instalments, :bxyj, :float ,default: 0
    add_column :instalments, :bzj, :float ,default: 0
    add_column :instalments, :qt, :float ,default: 0
    add_column :instalments, :fxj, :float ,default: 0
  end
end
