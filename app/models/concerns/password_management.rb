module PasswordManagement
  extend ActiveSupport::Concern

  def process_update_password(old_password, password)
    validate_old_password(old_password, password)
    reset_password!(password)
  end

  def process_forgot_password
    generate_reset_password_token!
    UserMailer.forgot_password(self).deliver if self.class == User
    AdminMailer.forgot_password(self).deliver if self.class == Admin
  end

  def process_reset_password(password)
    raise ExceptionHandler::InvalidToken, Message.link_expired unless present_and_has_valid_token
    reset_password!(password)
  end

  def generate_token
    SecureRandom.urlsafe_base64
  end

  private

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

  def generate_reset_password_token!
    self.reset_password_token = generate_token
    self.reset_password_token_sent_at = Time.now.utc
    save!
  end

  def present_and_has_valid_token
    present? && password_token_valid?
  end

  def password_token_valid?
    reset_password_token_sent_at + 4.hours > Time.now.utc
  end
end
