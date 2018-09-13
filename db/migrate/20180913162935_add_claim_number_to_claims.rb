class AddClaimNumberToClaims < ActiveRecord::Migration[5.2]
  def change
    add_column :claims, :claim_number, :string
  end
end
