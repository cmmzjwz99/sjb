class AddJournalIncome < ActiveRecord::Migration[5.1]
  def change
    add_column :ssc_journals, :income, :float,default: 0
  end
end
