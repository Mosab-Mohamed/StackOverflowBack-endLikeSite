class AlterQuestion < ActiveRecord::Migration
  def up
  	add_column :questions, :comments_number, :integer , default: 0 
  end

  def down
  	remove_column :questions, :comments_number
  end
end
