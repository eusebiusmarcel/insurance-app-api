class CreatePaymentDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :payment_details do |t|
      t.integer :policy_id
      t.string :month
      t.string :year

      t.timestamps
    end
  end
end
