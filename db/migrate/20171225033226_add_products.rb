class AddProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :name
      t.float :lx ,default:1
      t.integer :fqlx ,default:1
      t.integer :sbqs
      t.float :gpsfy,default:0
      t.float :jjf,default:0
      t.float :ffw,default:0
      t.float :gpsllf,default:0

      t.timestamps null: false
    end
  end
end
