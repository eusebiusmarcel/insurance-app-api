class AuthorizeApiRequest
  def initialize(headers = {})
    @headers = headers
  end

  def call_user
    {
      user: user
    }
  end

  def call_admin
    {
      admin: admin
    }
  end

  private

  attr_reader :headers

  def user
    @user ||= User.find(decoded_auth_token[:user_id]) if decoded_auth_token
  rescue ActiveRecord::RecordNotFound => error
    raise(
      ExceptionHandler::InvalidToken,
      ("#{Message.invalid_token} #{error.message}")
    )
  end

  def admin
    @admin ||= Admin.find(decoded_auth_token[:admin_id]) if decoded_auth_token
  rescue ActiveRecord::RecordNotFound => error
    raise(
      ExceptionHandler::InvalidToken,
      ("#{Message.invalid_token} #{error.message}")
    )
  end

  def decoded_auth_token
    @decoded_auth_token ||= JsonWebToken.decode(http_auth_header)
  end

  def http_auth_header
    if headers['Authorization'].present?
      return headers['Authorization'].split(' ').last
    end
      raise(ExceptionHandler::MissingToken, Message.missing_token)
  end
end