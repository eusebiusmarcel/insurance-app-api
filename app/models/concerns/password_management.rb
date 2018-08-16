module PasswordManagement
  extend ActiveSupport::Concern

  def validate_old_password(old_password, password)
    raise ExceptionHandler::AttributesNotComplete, 'Masukkan password lama' if old_password.blank?
    raise ExceptionHandler::AttributesNotComplete, 'Masukkan password baru' if password.blank?
    raise ExceptionHandler::AuthenticationError, Message.unauthorized unless authenticate(old_password)
  end

  def reset_password!(password)
    self.reset_password_token = nil
    self.password = password
    save!
  end

  def process_update_password(old_password, password)
    validate_old_password(old_password, password)
    reset_password!(password)
  end
end
