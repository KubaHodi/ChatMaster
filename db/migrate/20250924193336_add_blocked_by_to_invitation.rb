class AddBlockedByToInvitation < ActiveRecord::Migration[8.0]
  def change
    add_column :invitations, :blocked_by, :integer
  end
end
