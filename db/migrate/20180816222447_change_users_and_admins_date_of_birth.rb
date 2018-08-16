class ChangeUsersAndAdminsDateOfBirth < ActiveRecord::Migration[5.2]
  def change
    reversible do |dir|
      change_table :users do |t|
        dir.up   { t.change :date_of_birth, 'date USING CAST(date_of_birth AS date)' }
        dir.down { t.change :date_of_birth, :string }
      end

      change_table :admins do |t|
        dir.up   { t.change :date_of_birth, 'date USING CAST(date_of_birth AS date)' }
        dir.down { t.change :date_of_birth, :string }
      end
    end
  end
end
