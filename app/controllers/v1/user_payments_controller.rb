class V1::UserPaymentsController < ApplicationController
  before_action :authenticate_user
  def index
    payments = current_user.payments
    render json: { status: 'OK', payments: payments }, status: :ok
  end

  def show
    payment = Payment.find(params[:id])
    raise ExceptionHandler::AuthenticationError, Message.unauthorized unless current_user.payments.include?(payment)
    render json: { status: 'OK', payments: payment }, status: :ok
  end
end
