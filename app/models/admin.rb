class Admin < ApplicationRecord
  has_secure_password
  validates_presence_of :name, :email, :password_confirmation
end
