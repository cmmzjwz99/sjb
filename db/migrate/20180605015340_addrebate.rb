class Addrebate < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :effective_journal, :float ,default:0
    add_column :users, :rebate, :float,default:0
  end
end
