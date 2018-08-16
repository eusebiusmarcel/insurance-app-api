class AddResetPasswordTokenToUsersAndAdmins < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :reset_password_token, :string
    add_column :admins, :reset_password_token, :string
  end
end
