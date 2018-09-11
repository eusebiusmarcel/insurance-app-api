class V1::ClaimsManagementController < ApplicationController
  before_action :set_policy, only: %i[show_claims_of_one_policy create]
  before_action :authenticate_admin
  attr_reader :policy, :status
  attr_accessor :claim
  def index
    claims = Claim.all.order(:id)
    render json: { status: 'OK', claims: claims }, status: :ok
  end

  def show_claims_of_one_policy
    claims = policy.claims.all.order(:id)
    render json: { status: 'OK', claims: claims }, status: :ok
  end

  def create
    claim = policy.claims.new(claim_params)
    puts claim_params
    claim.save!
    render json: { status: 'OK', claim: claim }, status: :created
  end

  def change_status
    @claim = Claim.find(param[:id])
    @status = params[:status]
    claim.status = status
    save_time_of_change_status
    claim.save!
  end

  private

  def claim_params
    params.permit(:amount)
  end

  def set_policy
    @policy = Policy.find(params[:id])
  end

  def save_time_of_change_status
    claim.requirements_accepted_at = Time.now if status == :requirements_accepted
    claim.on_process_at = Time.now if status == :on_process
    claim.success_or_rejected_at = Time.now if status == :success || status == :rejected
  end
end
