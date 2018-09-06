class V1::UserPoliciesController < ApplicationController
  before_action :authenticate_user
  def show_user_policies
    policies = current_user.policies.order(:id).page(params[:page])
    render json: { status: 'OK', policies: policies }, status: :ok
  end
end
