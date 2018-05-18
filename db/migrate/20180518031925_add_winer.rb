class AddWiner < ActiveRecord::Migration[5.1]
  def change
    add_column :games,:win_team,:integer
  end
end
