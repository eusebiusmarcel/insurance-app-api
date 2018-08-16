class AddIndexToUsersAndAdminsEmail < ActiveRecord::Migration[5.2]
  def change
    add_index :users, :email, unique: true
    add_index :admins, :email, unique: true
  end
end
