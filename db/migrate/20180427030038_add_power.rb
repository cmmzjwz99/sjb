class AddPower < ActiveRecord::Migration[5.1]
  def change
    add_column :users,:identity,:integer
  end
end
