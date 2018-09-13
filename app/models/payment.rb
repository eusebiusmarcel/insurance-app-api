class Payment < ApplicationRecord
  belongs_to :policy
  belongs_to :user

  def as_json(*)
    super(methods: %i[policy_number premium_per_month])
  end

  def policy_number
    policy.policy_number
  end

  def premium_per_month
    policy.premium_per_month
  end
end
