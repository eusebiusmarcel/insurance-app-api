class CreatePolishes < ActiveRecord::Migration[5.2]
  def change
    create_table :polishes do |t|
      t.string :polish_number
      t.index :polish_number, unique: true
      t.integer :user_id
      t.string :object_name
      t.string :object_description
      t.integer :insurance_type
      t.integer :price_per_month
      t.integer :payment_due_date
      t.integer :limit_per_year
      t.integer :balance
      t.integer :deposit
      t.string :document_url
      t.integer :status
      t.date :expired_at

      t.timestamps
    end
  end
end
