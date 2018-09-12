class RenamePaymentDetailsToPayments < ActiveRecord::Migration[5.2]
  def change
    rename_table :payment_details, :payments
  end
end
