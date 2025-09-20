class AddUsernameToInvitation < ActiveRecord::Migration[8.0]
  def change
    add_column :invitations, :username, :string
  end
end
