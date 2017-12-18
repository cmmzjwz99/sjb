class AddFirstVerify < ActiveRecord::Migration
  def change
    add_column :loans, :idcard, :string
    add_column :loans, :name, :string
    add_column :loans, :phone, :string
    add_column :loans, :source, :string
  end
end
