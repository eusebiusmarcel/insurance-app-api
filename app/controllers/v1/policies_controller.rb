class V1::PoliciesController < ApplicationController
  before_action :authenticate_admin, 
                only: %i[index show_policies_of_one_user create create_by_csv]
  before_action :authenticate_user, only: %i[show_user_policies]
  def index
    policies = Policy.all.order(:id)
    render json: { status: 'OK', policies: policies }, status: :ok
  end

  def show_policies_of_one_user
    user = User.find(params[:id])
    policies = user.policies.all.order(:id)
    render json: { status: 'OK', policies: policies }, status: :ok
  end

  def create
    user = User.find(params[:user_id])
    policy = user.policies.new(policy_params)
    policy.balance = policy.limit_per_year
    policy.save!
    UserMailer.with(user: user, policy: policy).policy_registered.deliver
    render json: { status: "Policy berhasil dibuat", result: policy }, status: :created
  end

  # def create_by_csv
  # end

  def show_user_policies
    render json: { status: 'OK', policies: current_user.policies }, status: :ok
  end

  private

  def policy_params
    params.permit(:policy_number, :insured_item, :item_description,
                  :insurance_type, :premium_per_month, :payment_due_date,
                  :limit_per_year, :deposit, :document_url)
  end
end
