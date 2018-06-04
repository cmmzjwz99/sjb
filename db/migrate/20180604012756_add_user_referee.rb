class AddUserReferee < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :referee, :string
  end
end
