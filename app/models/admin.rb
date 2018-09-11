class Admin < ApplicationRecord
  include PasswordManagement
  mount_uploader :avatar, AvatarUploader

  before_save { email.downcase! }
  has_secure_password
  validates :name, presence: true, length: { in: 3..50 }
  validates :email, presence: true, format: { with: EMAIL_REGEX }, 
                    uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { in: 6..30 }, allow_nil: true

  def as_json(*)
    super(except: %i[password_digest reset_password_token reset_password_token_sent_at])
  end
end
