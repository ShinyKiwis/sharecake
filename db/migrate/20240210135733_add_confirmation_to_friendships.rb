class AddConfirmationToFriendships < ActiveRecord::Migration[7.1]
  def change
    add_column :friendships, :confirmation, :boolean, :default => false
  end
end
