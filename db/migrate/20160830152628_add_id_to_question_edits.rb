class AddIdToQuestionEdits < ActiveRecord::Migration
  def up
    add_column :question_edits, :id, :primary_key
  end

  def down
    remove_column :question_edits, :id
  end
end
