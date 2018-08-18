class Polish < ApplicationRecord
  belongs_to :user
  validates :polish_number, presence: true, uniqueness: { case_sensitive: false }
  enum insurance_type: { cyber_privacy_risk: 0, mobile_type: 1, social_media_account: 2 }
  enum status: { active: 0, inactive: 1 }
end
