class AddLoanLocation < ActiveRecord::Migration[5.1]
  def change
    add_column :loans, :location, :string
    add_column :loans, :basic_verify, :string,default: "verifyfail"
  end
end
