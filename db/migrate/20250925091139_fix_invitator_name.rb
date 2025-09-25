class FixInvitatorName < ActiveRecord::Migration[8.0]
  def self.up
    rename_column :invitations, :status_invitator, :status_invited
  end

  def self.down
  end
end
