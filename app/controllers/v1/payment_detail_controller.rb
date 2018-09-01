class V1::PaymentDetailController < ApplicationController
  before_action :authenticate_admin, only: [:detail]
  def detail
    payment_detail = PaymentDetail.where(policy_id: params[:policy_id])
    render json: { status: 'OK', detail: payment_detail }, status: :ok
  end
end
