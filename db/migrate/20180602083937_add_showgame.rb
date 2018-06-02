class AddShowgame < ActiveRecord::Migration[5.1]
  def change
    add_column :games, :show, :boolean,default: true
  end
end
