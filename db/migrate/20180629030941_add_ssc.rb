class AddSsc < ActiveRecord::Migration[5.1]
  def change
    create_table :ssc_games do |t|
      #开奖期号
      t.string :issue
      #开奖号码
      t.string :code
      #开奖日期
      t.datetime :time
      t.integer :status ,defalut:0
      t.timestamps null: false
    end
    create_table :ssc_orders do |t|
      #号码
      t.integer :category
      t.integer :code
      t.float :odds
      t.references :user
      t.references :ssc_game
      t.float :point
      t.float :get_point
      t.integer :status ,defalut:0
      t.timestamps null: false
    end
  end
end
