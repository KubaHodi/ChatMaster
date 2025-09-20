class AddStatusAndRecipientToInvitations < ActiveRecord::Migration[8.0]
  def change
    add_column :invitations, :status, :integer, default: 0, null: false
    add_reference :invitations, :recipent, foreign_key: { to_table: :users }, null: true

    add_column :invitations, :expires_at, :datetime
    add_index :invitations, :status
  end
end
