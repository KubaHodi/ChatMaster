class RemoveEmailFromInvitations < ActiveRecord::Migration[8.0]
  def change
    remove_column :invitations, :email, :string
  end
end
