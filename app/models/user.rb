class User < ApplicationRecord
  has_secure_password
<<<<<<< HEAD
  validates_presence_of :name, :email, :password_confirmation,
                        :birth_place, :birth_date
=======
  validates_presence_of :name, :email, :password_confirmation
>>>>>>> f9bafd95049b82aa7f79ce87698bd1aeee7fb895
end
