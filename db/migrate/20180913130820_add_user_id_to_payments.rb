class AddUserIdToPayments < ActiveRecord::Migration[5.2]
  def change
    add_column :payments, :user_id, :integer
  end
end
