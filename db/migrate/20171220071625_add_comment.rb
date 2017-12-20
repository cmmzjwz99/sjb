class AddComment < ActiveRecord::Migration[5.1]
  def change
    add_column :loan_comments,:content,:string
  end
end
