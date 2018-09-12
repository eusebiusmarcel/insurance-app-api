class V1::PaymentsController < ApplicationController
  before_action :authenticate_admin, only: [:detail, :create]
  before_action :authenticate_user, only: [:detail_by_user]

  def create
    policy = Policy.find_by(policy_number: params[:policy_number])
    raise ActiveRecord::RecordNotFound, Message.policy_number_not_found if policy.blank?
    payment = policy.payment.new(payment_params)
    payment.save!
    render json: { status: "Payment berhasil dibuat", result: payment }, status: :created
  end

  def detail
    payment = Payment.where(policy_id: params[:policy_id])
    render json: { status: 'OK', detail: payment }, status: :ok
  end

  def detail_by_user
  	policy = Policy.find_by(id: params[:policy_id], user_id: current_user)
  	raise ActiveRecord::RecordNotFound, Message.policy_number_not_found if policy.blank?
    payment = Payment.where(policy_id: params[:policy_id])
    render json: { status: 'OK', detail: payment }, status: :ok
  end

  private

  def payment_params
    params.permit(:month, :year)
  end
end
