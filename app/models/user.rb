class User < ApplicationRecord
  has_secure_password
  validates :name, presence: true, length: { in: 3..50 }, format: { with: NAME_REGEX, message: 'must include letter' } 
  validates :email, presence: true, format: { with: EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :password, allow_nil: true, length: { in: 6..30 }
  validates_presence_of :password_confirmation, :address, :place_of_birth, :date_of_birth
end
