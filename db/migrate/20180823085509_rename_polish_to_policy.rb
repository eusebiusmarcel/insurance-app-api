class RenamePolishToPolicy < ActiveRecord::Migration[5.2]
  def change
    rename_table :polishes, :policies
    rename_column :policies, :polish_number, :policy_number
  end
end
