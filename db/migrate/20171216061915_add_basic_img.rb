class AddBasicImg < ActiveRecord::Migration[5.1]
  def change
    add_column :basic_messages,:sqb, :string
    add_column :basic_messages,:clxxb, :string
    add_column :basic_messages,:cljcb, :string
    add_column :basic_messages,:yybspb, :string
    add_column :basic_messages,:csb, :string
  end
end
