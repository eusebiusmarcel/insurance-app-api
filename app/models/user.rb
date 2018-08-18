class User < ApplicationRecord
  include PasswordManagement
  before_save { email.downcase! }
  has_secure_password
  has_many :polishes
  validates :name, presence: true, length: { in: 3..50 }
  validates :email, presence: true, format: { with: EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { in: 6..30 }, allow_nil: true
  validates :id_card_number, presence: true, uniqueness: true
  validates :gender, inclusion: { in: %w[perempuan laki_laki], message: 'perempuan atau laki_laki?' }
  enum gender: { perempuan: 0, laki_laki: 1 }
  validates :phone_number, presence: true, format: { with: PHONE_REGEX }
  validates_presence_of :address, :place_of_birth, :date_of_birth
end
