class V1::PaymentDetailController < ApplicationController
  before_action :authenticate_admin, only: [:detail, :create]
  def create
    policy = Policy.find_by(policy_number: params[:policy_number])
    raise ActiveRecord::RecordNotFound, Message.policy_number_not_found if policy.blank?
    payment_details = policy.payment_details.new(payment_params)
    payment_details.save!
    render json: { status: "Payment berhasil dibuat", result: payment_details }, status: :created
  end
  def detail
    payment_detail = PaymentDetail.where(policy_id: params[:policy_id])
    render json: { status: 'OK', detail: payment_detail }, status: :ok
  end

  private

  def payment_params
    params.permit(:month, :year)
  end
end
