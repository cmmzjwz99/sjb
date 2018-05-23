class AddFeijingmatch < ActiveRecord::Migration[5.1]
  def change
    create_table :fj_matches do |t|
      t.string :match_id
      t.string :team1
      t.string :team2
      t.string :name
      t.datetime :time
      t.timestamps null: false
    end
  end
end
