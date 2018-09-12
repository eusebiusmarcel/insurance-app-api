class CreateClaims < ActiveRecord::Migration[5.2]
  def change
    create_table :claims do |t|
      t.integer :policy_id
      t.integer :amount
      t.integer :status, default: 0
      t.datetime :requirements_accepted_at
      t.datetime :on_process_at
      t.datetime :success_or_rejected_at

      t.timestamps
    end
  end
end
