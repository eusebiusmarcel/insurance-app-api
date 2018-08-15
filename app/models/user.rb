class User < ApplicationRecord
  has_secure_password
  validates_presence_of :name, :email, :password_confirmation, :address,
                        :place_of_birth, :date_of_birth
end
