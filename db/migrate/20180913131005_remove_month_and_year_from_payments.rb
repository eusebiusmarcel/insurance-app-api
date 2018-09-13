class RemoveMonthAndYearFromPayments < ActiveRecord::Migration[5.2]
  def change
    remove_column :payments, :month
    remove_column :payments, :year
  end
end
