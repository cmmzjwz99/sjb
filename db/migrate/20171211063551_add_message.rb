class AddMessage < ActiveRecord::Migration[5.1]
  def change
    add_column :car_messages, :no, :string
    add_column :car_messages, :name, :string
  end
end
