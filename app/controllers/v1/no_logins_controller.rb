class V1::NoLoginsController < ApplicationController
  def index_user
    users = User.includes(:policies).all.order(:id)
    users_and_insurance_type = []
    users.each do |user|
      insurance_type = []
      user.policies.each do |policy|
        insurance_type.push(policy.insurance_type) unless insurance_type.include?(policy.insurance_type)
      end
      users_and_insurance_type.push(user: user, insurance_types: insurance_type)
    end
    users_and_insurance_type_per_page = users_and_insurance_type
    render json: { status: 'OK', total_users: users.count, users: users_and_insurance_type_per_page }, status: :ok
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