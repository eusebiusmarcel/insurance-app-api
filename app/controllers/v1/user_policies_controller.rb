class V1::UserPoliciesController < ApplicationController
  before_action :authenticate_user
  def index
    policies = current_user.policies.all.order(:id)
    render json: { status: 'OK', policies: policies }, status: :ok
  end

  def show
    policy = Policy.find(params[:id])
    raise ExceptionHandler::AuthenticationError, Message.unauthorized unless current_user.policies.include?(policy)
    render json: { status: 'OK', policies: policy }, status: :ok
  end
end
