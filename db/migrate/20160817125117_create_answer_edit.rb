class CreateAnswerEdit < ActiveRecord::Migration
  def change
    create_table :answer_edits do |t|

    	t.integer :user_id		,null: false
    	t.integer :answer_id		,null: false
    	t.string :body
    end

    add_index :answer_edits,[:user_id,:answer_id]
  end
end
