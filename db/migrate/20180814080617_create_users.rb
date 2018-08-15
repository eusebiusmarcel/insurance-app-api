class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :address
      t.string :place_of_birth
      t.string :date_of_birth

      t.timestamps
    end
  end
end
