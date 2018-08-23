class AddAvatarToUserAndAdmin < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :avatar, :string
    add_column :admins, :avatar, :string
  end
end
