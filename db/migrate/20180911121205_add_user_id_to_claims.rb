class AddUserIdToClaims < ActiveRecord::Migration[5.2]
  def change
    add_column :claims, :user_id, :integer
  end
end
