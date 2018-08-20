class Authenticate
  def initialize(email, password)
    @email = email
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
    validate(User)
  end

  def admin
    validate(Admin)
  end

  def validate(account)
    account = account.find_by(email: email)
    return account if account && account.authenticate(password)
    raise(ExceptionHandler::AuthenticationError, Message.invalid_credentials)
  end
end
