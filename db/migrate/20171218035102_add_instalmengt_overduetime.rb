class AddInstalmengtOverduetime < ActiveRecord::Migration[5.1]
  def change
    add_column :instalments,:overdue_time, :datetime
    add_column :instalments,:gpsfy,:float, default: 0
    add_column :instalments,:gpsllf,:float, default: 0
    add_column :instalments,:jjf,:float, default: 0
    add_column :instalments,:zjfd,:float, default: 0
    add_column :instalments,:fwf,:float, default: 0
    add_column :instalments,:bj,:float, default: 0
    add_column :instalments,:lx,:float, default: 0
    add_column :instalments,:dkye,:float, default: 0
  end
end
