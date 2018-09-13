class Payment < ApplicationRecord
  belongs_to :policy
  belongs_to :user

  def as_json(*)
    super(methods: %i[police_number premium_per_month])
  end

  def police_number
    policy.police_number
  end

  def premium_per_month
    policy.premium_per_month
  end
end
