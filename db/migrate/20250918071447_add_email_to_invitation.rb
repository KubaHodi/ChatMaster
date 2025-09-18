class AddEmailToInvitation < ActiveRecord::Migration[8.0]
  def change
    add_column :invitations, :email, :string
  end
end
