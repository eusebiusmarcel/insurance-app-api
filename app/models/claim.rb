class Claim < ApplicationRecord
  include ValidateClaimStatus

  belongs_to :policy
  belongs_to :user

  before_create :set_claim_number

  enum status: { 'Requirements Accepted': 0, 'On Process': 1, 'Success': 2, 'Rejected': 3 }

  validates :amount, presence: true
  validate :status_should_be_valid

  def as_json(*)
    super(methods: %i[policy_number insurance_type])
  end

  def insurance_type
    policy.insurance_type
  end

  def policy_number
    policy.policy_number
  end

  private

  def set_claim_number
    last_claim = Claim.joins(:policy).where(policies: { policy_number: policy_number }).references(:policy).last
    last_4_digit_of_last_claim_number = last_claim.claim_number[14..-1].to_i unless last_claim.blank?
    last_4_digit_of_last_claim_number = 0 if last_claim.blank?
    self.claim_number = "#{policy_number}-" + (last_4_digit_of_last_claim_number + 1).to_s.rjust(4, "0")
  end
end
