class CreateTagQuestions < ActiveRecord::Migration
  def change
    create_table :tag_questions do |t|

		t.integer :tag_id		,null: false
		t.integer :question_id		,null: false

      t.timestamps null: false
    end

    add_index :tag_questions,[:tag_id,:question_id]
  end
end
