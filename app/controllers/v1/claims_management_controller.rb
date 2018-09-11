class V1::ClaimsManagementController < ApplicationController
  before_action :authenticate_admin
  attr_reader :policy, :status
  attr_accessor :claim
  def index
    claims = Claim.all.order(:id)
    render json: { status: 'OK', claims: claims }, status: :ok
  end

  def show_claims_of_one_policy
    user = User.find(params[:id])
    claims = user.claims.all.order(:id)
    render json: { status: 'OK', claims: claims }, status: :ok
  end

  def create
    policy = Policy.find(params[:id])
    claim = policy.claims.new(claim_params)
    claim.user_id = policy.user_id
    claim.requirements_accepted_at = Time.now
    claim.save!
    render json: { status: 'OK', claim: claim }, status: :created
  end

  def change_status
    @claim = Claim.find(params[:id])
    @status = params[:status]
    claim.update!(params.permit(:status))
    save_time_of_change_status
    render json: { status: 'OK', claim: claim }, status: :ok
  end

  private

  def claim_params
    params.permit(:amount)
  end

  def save_time_of_change_status
    claim.requirements_accepted_at = Time.now if status == 0 || status == 'Requirements Accepted'
    claim.on_process_at = Time.now if status == 1 || status == 'On Process'
    claim.success_or_rejected_at = Time.now if status == 2 || status == 3 || status == 'Success' || status == 'Rejected'
  end
end
