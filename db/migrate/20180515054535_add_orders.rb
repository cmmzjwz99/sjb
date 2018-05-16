class AddOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.float :point
      t.float :get_point
      t.float :odds
      t.integer :team
      t.integer :status
      t.references :user
      t.references :game
      t.timestamps null: false
    end
  end
end
