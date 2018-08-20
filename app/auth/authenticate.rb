class Authenticate
  def initialize(email, password)
    @email = email.downcase
    @password = password
  end

  def call_user
    JsonWebToken.encode(user_id: user.id) if user
  end

  def call_admin
    JsonWebToken.encode(admin_id: admin.id) if admin
  end

  private

  attr_reader :email, :password

  def user
    search(User)
  end

  def admin
    search(Admin)
  end

  def search(account)
    @account = account.find_by(email: email)
    valid_credentials?
  end

  def valid_credentials?
    raise(ExceptionHandler::AuthenticationError, Message.invalid_email) unless @account
    raise(ExceptionHandler::AuthenticationError, Message.invalid_password) unless @account.authenticate(password)
    @account
  end
end
