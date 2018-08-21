class JsonWebToken
  HMAC_SECRET = Rails.application.credentials.read

  def self.encode(payload, exp = 1.year.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, HMAC_SECRET)
  end

  def self.decode(token)
    body = JWT.decode(token, HMAC_SECRET)[0]
    HashWithIndifferentAccess.new body
  rescue JWT::DecodeError => error
    raise ExceptionHandler::InvalidToken, error.message
  end
end
