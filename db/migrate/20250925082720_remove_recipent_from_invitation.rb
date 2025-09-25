class RemoveRecipentFromInvitation < ActiveRecord::Migration[8.0]
  def change
    remove_column :invitations, :recipent_id
  end
end
