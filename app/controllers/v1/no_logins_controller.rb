class V1::NoLoginsController < ApplicationController
  def index_user
    users = User.order(:id).page(params[:page])
    render json: { status: 'OK', total_users: users.count, users: users }, status: :ok
  end

  def index_policy
    policies = Policy.order(:id).page(params[:page])
    render json: { status: 'OK', policies: policies }, status: :ok
  end

  def show_policies_of_one_user
    user = User.find(params[:id])
    policies = user.policies.order(:id).page(params[:page])
    render json: { status: 'OK', policies: policies }, status: :ok
  end

  def show_user
    user = User.find(params[:id])
    render json: { status: 'OK', user: user }, status: :ok
  end

  def show_policy
    policy = Policy.find(params[:id])
    render json: { status: 'OK', policy: policy }, status: :ok
  end
end