class AddTeams < ActiveRecord::Migration[5.1]
  def change
    create_table :teams do |t|
      t.string :name
      t.timestamps null: false
    end

    add_column :basic_messages, :dyzy, :string
    add_column :users, :team, :string, default: '无团队'
  end
end
