class AddResetPasswordTokenSentAtToUsersAndAdmins < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :reset_password_token_sent_at, :datetime
    add_column :admins, :reset_password_token_sent_at, :datetime
  end
end
