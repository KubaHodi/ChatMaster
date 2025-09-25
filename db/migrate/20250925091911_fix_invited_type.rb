class FixInvitedType < ActiveRecord::Migration[8.0]
  def change
    change_column_default :invitations, :status_invited, default: 0, null: false
  end
end
