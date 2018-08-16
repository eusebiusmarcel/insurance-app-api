module ExceptionHandler
  extend ActiveSupport::Concern

  class AuthenticationError < StandardError; end
  class AttributesNotComplete < StandardError; end

  included do
      rescue_from ActiveRecord::RecordInvalid, with: :four_twenty_two
      rescue_from ExceptionHandler::AuthenticationError, with: :unauthorized_request
      rescue_from ExceptionHandler::AttributesNotComplete, with: :four_twenty_two

      rescue_from ActiveRecord::RecordNotFound do |error|
          render json: { result: false, message: error.message }, status: :not_found
      end
  end

  private

  def four_twenty_two(error)
      render json: { status: "Failed", message: error.message }, status: :unprocessable_entity
  end

  def unauthorized_request(error)
      render json: { status: "Failed", message: error.message }, status: :unauthorized
  end
end