class AddUserArea < ActiveRecord::Migration[5.1]
  def change
    create_table :user_areas do |t|
      t.string :name
      t.references :loan, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
