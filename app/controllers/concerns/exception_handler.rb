module ExceptionHandler
  extend ActiveSupport::Concern

  class AuthenticationError < StandardError; end
  class AttributesNotComplete < StandardError; end
  class TellingLie < StandardError; end
  class MissingToken < StandardError; end
  class InvalidToken < StandardError; end
  class ExpiredSignature < StandardError; end

  included do
    rescue_from ActiveRecord::RecordInvalid, with: :four_twenty_two
    rescue_from ExceptionHandler::AuthenticationError, with: :unauthorized_request
    rescue_from ExceptionHandler::AttributesNotComplete, with: :four_twenty_two
    rescue_from ExceptionHandler::TellingLie, with: :two_hundred
    rescue_from ExceptionHandler::MissingToken, with: :four_twenty_two
    rescue_from ExceptionHandler::InvalidToken, with: :four_ninety_eight
    rescue_from ExceptionHandler::ExpiredSignature, with: :four_ninety_eight

    rescue_from ActiveRecord::RecordNotFound do |error|
      render json: { result: false, message: error.message }, status: :not_found
    end
  end

  private

  def two_hundred(succeed)
    render json: { status: "OK", message: succeed.message }, status: :ok
  end

  def four_twenty_two(error)
    render json: { status: "Failed", message: error.message }, status: :unprocessable_entity
  end

  def unauthorized_request(error)
    render json: { status: "Failed", message: error.message }, status: :unauthorized
  end

  def four_ninety_eight(error)
    render json: { message: error.message }, status: :invalid_token
  end
end