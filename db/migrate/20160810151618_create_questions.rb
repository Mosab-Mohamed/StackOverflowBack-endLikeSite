class CreateQuestions < ActiveRecord::Migration
  def change

    create_table :questions do |t|

    	t.string :title		,null: false
    	t.text :body		,null: false
    	t.string :status		, default: "un_resolved" 
    	t.integer :views		, default: 0 
    	t.integer :user_id		,null: false

      t.timestamps null: false
    end

    add_index :questions ,:user_id
  end
end
