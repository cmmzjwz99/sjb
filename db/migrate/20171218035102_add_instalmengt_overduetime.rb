class AddInstalmengtOverduetime < ActiveRecord::Migration[5.1]
  def change
    add_column :instalments,:overdue_time, :datetime
  end
end
