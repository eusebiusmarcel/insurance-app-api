class Policy < ApplicationRecord
  belongs_to :user
  validates :policy_number, presence: true, uniqueness: { case_sensitive: false }
  validates_presence_of :insured_item, :premium_per_month, :limit_per_year, :balance
  validates :payment_due_date, presence: true, inclusion: { 
    in: 1..28, message: 'pilih tanggal 1 sampai 28' }
  validates :insurance_type, inclusion: {
    in: %w[cyber_privacy_risk mobile_tablet social_media_account],
    message: 'cyber_privacy_risk (0), mobile_tablet (1), atau social_media_account (2)' }
  enum insurance_type: { cyber_privacy_risk: 0, mobile_tablet: 1, social_media_account: 2 }
  enum status: { active: 0, inactive: 1 }
end
