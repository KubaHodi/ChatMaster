class AddAvatarToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :avatar, :attachment, default: "default_avatar.png"
  end
end
