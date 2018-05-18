class AddOdds < ActiveRecord::Migration[5.1]
  def change
    create_table :odds do |t|
      t.string :home_team
      t.string :away_team
      t.string :rule
      t.float :home_odd
      t.float :away_odd
      t.string :source
      t.timestamps null: false
    end
  end
end
