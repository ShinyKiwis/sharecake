class AddFriendCodeToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :friend_code, :string
  end
end
