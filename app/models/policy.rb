class Policy < ApplicationRecord
  belongs_to :user
  validates :policy_number, presence: true, uniqueness: { case_sensitive: false }
  validates_presence_of :insured_item, :premium_per_month, :limit_per_year, :balance
  validates :payment_due_date, presence: true, inclusion: { 
    in: 1..28, message: 'pilih tanggal 1 sampai 28' }
  validates :insurance_type, inclusion: {
    in: ['Cyber Privacy Risk', 'Mobile & Tablet', 'Social_Media_Account'],
    message: 'Cyber Privacy Risk (0), Mobile & Tablet (1), atau Social_Media_Account (2)' }
  enum insurance_type: { 'Cyber Privacy Risk': 0, 'Mobile & Tablet': 1, 'Social_Media_Account': 2 }
  enum status: { active: 0, inactive: 1 }
end
