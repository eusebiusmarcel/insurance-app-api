class Claim < ApplicationRecord
  include ValidateClaimStatus

  belongs_to :policy
  belongs_to :user

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
end
