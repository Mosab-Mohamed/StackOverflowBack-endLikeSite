class AddCommentsNumberToAnswer < ActiveRecord::Migration
  def up
  	add_column :answers, :comments_number, :integer , default: 0 
  end

  def down
  	remove_column :answers, :comments_number
  end
end
