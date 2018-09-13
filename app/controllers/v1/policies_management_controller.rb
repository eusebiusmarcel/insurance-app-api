class V1::PoliciesManagementController < ApplicationController
  before_action :authenticate_admin
  def index
    policies = Policy.all.order(:id)
    render json: { status: 'OK', policies: policies }, status: :ok
  end

  def create_by_csv
    Policy.import!(params[:file])
    render json: { created_policies: Policy.created_policies,
        failed_to_created_policies: Policy.failed_to_created_policies }, status: :ok
  end
end
