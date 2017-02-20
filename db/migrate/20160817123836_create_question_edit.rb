class CreateQuestionEdit < ActiveRecord::Migration
  def change
    create_table :question_edits, {:id => false} do |t|

    	t.integer :user_id		,null: false
    	t.integer :question_id		,null: false
    	t.string :body
    end
  
    add_index :question_edits,[:user_id,:question_id]
  end
end
