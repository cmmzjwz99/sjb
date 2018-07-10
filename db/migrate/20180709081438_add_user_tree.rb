class AddUserTree < ActiveRecord::Migration[5.1]
  def change
    create_table :user_referees do |t|
      t.integer :user
      t.integer :referee
      t.integer :level
      t.timestamps null: false
    end
    create_table :ssc_journals do |t|
      t.float :point  , default:0
      t.float :journal,default:0
      t.float :rebate,default:0
      t.references :user
      t.timestamps null: false
    end
    create_table :ssc_journal_logs do |t|
      t.string :time
      t.float :journal
      t.float :income
      t.references :user
      t.timestamps null: false
    end
  end
end
