class CreateFavourites < ActiveRecord::Migration
  def change
    create_table :favourites do |t|

      t.integer :user_id		,null: false
      t.integer :question_id		,null: false

      t.timestamps null: false
    end

    add_index :favourites,[:user_id,:question_id]
  end
end
