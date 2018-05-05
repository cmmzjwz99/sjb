class AddProductStatus < ActiveRecord::Migration[5.1]
  def change
    add_column :products,:status,:boolean,default: true
    add_column :loans,:start_time,:datetime
  end
end
