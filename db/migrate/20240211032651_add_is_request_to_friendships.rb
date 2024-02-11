class AddIsRequestToFriendships < ActiveRecord::Migration[7.1]
  def change
    add_column :friendships, :is_request, :boolean, :default => false
  end
end
