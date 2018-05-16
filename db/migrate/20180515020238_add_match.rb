class AddMatch < ActiveRecord::Migration[5.1]
  def change

    create_table :matchs do |t|
      t.string :name
      t.string :team1
      t.string :team2
      t.integer :score1
      t.integer :score2
      t.integer :status
      t.datetime :start_time
      t.timestamps null: false
    end

    create_table :games do |t|
      t.string :name
      t.float :odds1
      t.float :odds2
      t.float :balance
      t.integer :category
      t.integer :status

      t.references :match
      t.timestamps null: false
    end
    add_column :users,:points,:float,default: 0.0
  end
end
