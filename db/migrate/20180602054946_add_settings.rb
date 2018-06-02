class AddSettings < ActiveRecord::Migration[5.1]
  def change
    create_table :settings do |t|
      t.string :val
      t.string :category
      t.timestamps null: false
    end
  end
end
