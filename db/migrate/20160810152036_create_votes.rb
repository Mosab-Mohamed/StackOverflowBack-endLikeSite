class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|

      t.integer :user_id		,null: false
      t.integer :votable_id		,null: false
      t.string :votable_type
      t.boolean :up_or_down

      t.timestamps null: false
    end

    add_index :votes,:user_id
    add_index :votes,[:votable_id,:votable_type]
  end
end
