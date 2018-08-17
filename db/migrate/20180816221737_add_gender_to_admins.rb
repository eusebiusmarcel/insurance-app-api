class AddGenderToAdmins < ActiveRecord::Migration[5.2]
  def change
    add_column :admins, :gender, :integer
  end
end
