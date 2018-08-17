class AddIdCardAndGenderToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :id_card_number, :string
    add_column :users, :gender, :integer
  end
end
