class RenameColumnsInPolicies < ActiveRecord::Migration[5.2]
  def change
    rename_column :policies, :object_name, :insured_item
    rename_column :policies, :object_description, :item_description
    rename_column :policies, :price_per_month, :premium_per_month
  end
end
