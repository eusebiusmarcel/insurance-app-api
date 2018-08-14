class CreateAdmins < ActiveRecord::Migration[5.2]
  def change
    create_table :admins do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :address
      t.string :birth_place
      t.string :birth_date

      t.timestamps
    end
  end
end
