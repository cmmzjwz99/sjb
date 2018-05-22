class AddMatchid < ActiveRecord::Migration[5.1]
  def change
    add_column :matchs,:match_id,:string
    add_column :games, :remark, :string
  end
end
