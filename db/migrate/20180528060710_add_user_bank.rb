class AddUserBank < ActiveRecord::Migration[5.1]
  def change
    create_table :user_banks do |t|
      t.string :bank
      t.string :no
      t.string :name
      t.references :user
      t.timestamps null: false
    end
  end
end
