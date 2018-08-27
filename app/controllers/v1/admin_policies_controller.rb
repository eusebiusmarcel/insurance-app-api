class V1::AdminPoliciesController < ApplicationController
  before_action :authenticate_admin
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
    user = User.find_by(email: params[:user_email].downcase)
    raise ActiveRecord::RecordNotFound, Message.user_email_unregistered if user.blank?
    policy = user.policies.new(policy_params)
    policy.balance = policy.limit_per_year
    policy.save!
    UserMailer.with(user: user, policy: policy).policy_registered.deliver
    render json: { status: "Policy berhasil dibuat", result: policy }, status: :created
  end

  # def create_by_csv
  # end

  private

  def policy_params
    params.permit(:policy_number, :insured_item, :item_description,
                  :insurance_type, :premium_per_month, :payment_due_date,
                  :limit_per_year, :deposit, :document_url)
  end
end
