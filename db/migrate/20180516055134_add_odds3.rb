class AddOdds3 < ActiveRecord::Migration[5.1]
  def change
    add_column :games,:odds3,:float
    add_column :games,:name1,:string
    add_column :games,:name2,:string
    add_column :games,:name3,:string
    remove_column :games,:balance
  end
end
