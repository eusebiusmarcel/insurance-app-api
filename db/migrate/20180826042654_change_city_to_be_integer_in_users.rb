class ChangeCityToBeIntegerInUsers < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :city, :integer, using: 'city::integer'
  end
end
