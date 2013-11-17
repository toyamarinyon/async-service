class CreateUsers < ActiveRecord::Migration
  def up
	  create_table :users do |table|
		  table.string :name, :null => false
		  table.timestamps
	  end
  end

  def down
	  drop_table :users
  end
end
