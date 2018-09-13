class V1::PaymentsManagementController < ApplicationController
  before_action :authenticate_admin
  def index
    payments = Payment.all.order(:id)
    render json: { status: 'OK', payments: payments }, status: :ok
  end

  def create
    policy = Policy.find(params[:id])
    payment = policy.payments.new
    payment.user_id = policy.user_id
    payment.save!
    render json: { status: 'OK', payment: payment }, status: :created
  end
end
