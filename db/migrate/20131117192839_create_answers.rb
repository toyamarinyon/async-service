class CreateAnswers < ActiveRecord::Migration
  def up
	  create_table :answers do |table|
		  table.integer :user_id, :null => false
		  table.integer :question_no, :null => false
		  table.integer :answer_no, :null => false
		  table.time :answer_time, :null => false
		  table.timestamps
	  end
  end

  def down
	  drop_table :answers
  end
end
