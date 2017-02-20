class AddAccessTokenToUser < ActiveRecord::Migration
  def up
    add_column :users, :access_token, :string
    add_column :users, :username, :string
  end

  def down
  	remove_column :users, :username
    remove_column :users, :access_token
  end
end
