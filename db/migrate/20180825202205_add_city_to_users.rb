class AddCityToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :city, :integer
  end
end
