class V1::NoLoginsController < ApplicationController
  def index_user
    users = User.all.order(:id)
    render json: users, status: :ok
  end

  def index_policy
    policies = Policy.all.order(:id)
    render json: policies, status: :ok
  end

  def show_policies_of_one_user
    user = User.find(params[:id])
    policies = user.policies.all.order(:id)
    render json: policies, status: :ok
  end

  def show_user
    user = User.find(params[:id])
    render json: user, status: :ok
  end

  def show_policy
    policy = Policy.find(params[:id])
    render json: policy, status: :ok
  end
end