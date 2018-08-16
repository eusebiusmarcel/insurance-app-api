class Admin < ApplicationRecord
  include PasswordManagement
  before_save { email.downcase! }
  has_secure_password
  validates :name, presence: true, length: { in: 3..50 }, format: { with: NAME_REGEX, message: 'must include letter' } 
  validates :email, presence: true, format: { with: EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { in: 6..30 }, allow_nil: true
  validates_presence_of :address, :place_of_birth, :date_of_birth
  validates :gender, inclusion: { in: %w[perempuan laki_laki], message: 'perempuan atau laki_laki?' }
  enum gender: { perempuan: 0, laki_laki: 1 }
end
