class AddFriendIdToInvitations < ActiveRecord::Migration[8.0]
  def change
    add_column :invitations, :friend_id, :integer
  end
end
