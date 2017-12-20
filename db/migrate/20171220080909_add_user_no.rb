class AddUserNo < ActiveRecord::Migration[5.1]
  def change
    add_column :users,:userno,:string
  end
end
