class V1::AdminPoliciesController < ApplicationController
  before_action :authenticate_admin
  def index
    policies = Policy.order(:id).page(params[:page])
    render json: { status: 'OK', policies: policies }, status: :ok
  end

  def show_policies_of_one_user
    user = User.find(params[:id])
    policies = user.policies.order(:id).page(params[:page])
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

  def upload_policy_document
    policy = Policy.find(params[:id])
    policy.remove_document_url! unless policy.document_url.blank?
    policy.update!(params.permit(:document_url))
    render json: { status: 'Document berhasil diupload.' }, status: :ok
  end

  def created_policies
    Policy.import!(params[:file])
    raise ActiveRecord::RecordNotFound, Message.email_unregistered if user.blank?
    render json: { created_policies: Policy.created_policies.as_json(except: %i[policy_number User.email insured_item item_description insurance_type premium_per_month payment_per_month]),
        failed_to_created_policies: Policy.failed_to_created_policies.as_json(except: %i[policy_number user_id insured_item item_description insurance_type premium_per_month payment_per_month])}, status: :ok
  end

  private

  def policy_params
    params.permit(:policy_number, :insured_item, :item_description,
                  :insurance_type, :premium_per_month, :payment_due_date,
                  :limit_per_year, :deposit, :document_url)
  end
end
