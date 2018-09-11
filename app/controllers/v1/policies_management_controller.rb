class V1::PoliciesManagementController < ApplicationController
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

  def upload_policy_document
    policy = Policy.find(params[:id])
    policy.remove_document_url! unless policy.document_url.blank?
    policy.update!(params.permit(:document_url))
    render json: { status: 'Document berhasil diupload.' }, status: :ok
  end

  def create_by_csv
    Policy.import!(params[:file])
    render json: { created_policies: Policy.created_policies,
        failed_to_created_policies: Policy.failed_to_created_policies }, status: :ok
  end

  private

  def policy_params
    params.permit(:policy_number, :insured_item, :item_description,
                  :insurance_type, :premium_per_month, :payment_due_date,
                  :limit_per_year, :deposit, :document_url)
  end
end
