class AddStatusInvitatorToInvitation < ActiveRecord::Migration[8.0]
  def change
    add_column :invitations, :status_invitator, :integer
  end
end
