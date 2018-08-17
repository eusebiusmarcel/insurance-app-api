class CreateAdmins < ActiveRecord::Migration[5.2]
  def change
    create_table :admins do |t|
      t.string :name
      t.string :email
      t.index :email, unique: true
      t.string :password_digest
      t.string :reset_password_token
      t.datetime :reset_password_token_sent_at

      t.timestamps
    end
  end
end
