class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.index :email, unique: true
      t.string :password_digest
      t.string :id_card_number
      t.index :id_card_number, unique: true
      t.integer :gender
      t.string :address
      t.string :phone_number
      t.string :place_of_birth
      t.date :date_of_birth
      t.string :reset_password_token
      t.datetime :reset_password_token_sent_at

      t.timestamps
    end
  end
end
