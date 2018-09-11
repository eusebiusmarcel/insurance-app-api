class V1::UserClaimsController < ApplicationController
  before_action :authenticate_user
  def index
    claims = current_user.claims.all.order(:id)
    render json: { status: 'OK', claims: claims }, status: :ok
  end

  def show
    claim = Claim.find(params[:id])
    raise ExceptionHandler::AuthenticationError, Message.unauthorized unless current_user.claims.include?(claim)
    render json: { status: 'OK', claims: claim }, status: :ok
  end
end
