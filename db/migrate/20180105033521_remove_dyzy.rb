class RemoveDyzy < ActiveRecord::Migration[5.1]
  def change
    remove_column :basic_messages,:dyzy
  end
end
