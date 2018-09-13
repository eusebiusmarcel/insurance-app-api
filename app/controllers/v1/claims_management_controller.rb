class V1::ClaimsManagementController < ApplicationController
  before_action :authenticate_admin
  attr_accessor :claim
  def index
    claims = Claim.all.order(:id)
    render json: { status: 'OK', claims: claims }, status: :ok
  end

  def create
    policy = Policy.find(params[:id])
    raise ExceptionHandler::OnGoingClaim, Message.on_going_claim if policy.claim_status.include?('Requirements Accepted') || policy.claim_status.include?('On Process')
    claim = policy.claims.new(claim_params)
    raise ExceptionHandler::InvalidAmount, Message.invalid_claim_amount if claim.amount > policy.balance
    claim.user_id = policy.user_id
    claim.requirements_accepted_at = Time.now
    claim.save!
    render json: { status: 'OK', claim: claim }, status: :created
  end

  def change_status
    @claim = Claim.find(params[:id])
    claim.status = params[:status]
    update_time_of_status_change
    update_policy_balance
    claim.save!
    render json: { status: 'OK', claim: claim }, status: :ok
  end

  private

  def claim_params
    params.permit(:amount)
  end

  def update_time_of_status_change
    claim.requirements_accepted_at = Time.now if claim.status == 0 || claim.status == 'Requirements Accepted'
    claim.on_process_at = Time.now if claim.status == 1 || claim.status == 'On Process'
    claim.success_or_rejected_at = Time.now if claim.status == 2 || claim.status == 'Success'
    claim.success_or_rejected_at = Time.now if claim.status == 3 || claim.status == 'Rejected'
  end

  def update_policy_balance
    policy = claim.policy
    policy.balance = policy.balance - claim.amount if claim.status == 2 || claim.status == 'Success'
    policy.save!
  end
end
