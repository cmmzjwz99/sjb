class AddUserTeam < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :team
    add_column :basic_messages, :team, :string, default: '无团队'
    add_column :loans, :pass_time, :datetime
  end
end
