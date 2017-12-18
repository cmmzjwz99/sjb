class AddUserPower < ActiveRecord::Migration[5.1]
  def change
    create_table :user_powers do |t|
      t.boolean :input,default:false
      t.boolean :first_verify,default:false
      t.boolean :online_verify,default:false
      t.boolean :customer_verify,default:false
      t.boolean :car_verify,default:false
      t.boolean :user_manage,default:false
      t.boolean :financial,default:false

      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
    create_table :user_areas do |t|
      t.boolean :zjwz,default:false
      t.boolean :zjsxsz,default:false
      t.boolean :zjsxkq,default:false
      t.boolean :zjsxyc,default:false
      t.boolean :zjhz,default:false
      t.boolean :ahhf,default:false

      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
