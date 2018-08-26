class CreateGuests < ActiveRecord::Migration[5.2]
  def change
    create_table :guests do |t|
      t.string :name
      t.string :email
      t.integer :phone_number
      t.integer :insurance_type
      t.string :city

      t.timestamps
    end
  end
end
