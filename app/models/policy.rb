class Policy < ApplicationRecord
  include ValidateInsuranceType
  include ValidatePolicyStatus

  before_save{ policy_number.upcase! }

  belongs_to :user
  has_many :payments
  has_many :claims

  enum insurance_type: { 'Cyber Privacy Risk': 0, 'Mobile & Tablet': 1, 'Social Media Account': 2 }
  enum status: { active: 0, inactive: 1 }

  validates :policy_number, presence: true, uniqueness: { case_sensitive: false },
                            format: { with: POLICY_NUMBER_REGEX, message: Message.policy_number_regex }
  validates_presence_of :insured_item, :premium_per_month, :limit_per_year, :balance
  validates :payment_due_date, presence: true, inclusion: { 
    in: 1..28, message: 'pilih tanggal 1 sampai 28' }

  validate :insurance_type_should_be_valid
  validate :status_should_be_valid

  def claim_status
    claim_status = []
    claims.each do |claim|
      claim_status.push(claim.status) unless claim_status.include?(claim.status)
    end
    claim_status
  end

  class << self
    attr_accessor :created_policies, :failed_to_created_policies
  end

  def self.import!(file)
    @created_policies, @failed_to_created_policies = Array.new(2) { [] }
    CSV.foreach(file.path, headers: true) do |row|
      params = row.to_hash
      user = User.find_by(email: params["email"].downcase)
      failed_to_created_policies.push(policy_number: params["policy_number"], errors: { email: ['not registered'] } ) && next if user.blank?
      policy = user.policies.new(params.except("email"))
      policy.balance = policy.limit_per_year
      policy.payment_due_date = Time.now.strftime('%d').to_i if Time.now.strftime('%d').to_i <= 28
      policy.payment_due_date = 28 if Time.now.strftime('%d').to_i > 28
      policy.document_url = 'https://res.cloudinary.com/quind-cloud/image/upload/v1536858697/SPECIMEN-Quind_Policy.pdf'
      if policy.save
        UserMailer.with(user: user, policy: policy).policy_registered.deliver
        created_policies.push(policy)
      else
        failed_to_created_policies.push(policy_number: policy.policy_number, errors: policy.errors)
        next
      end
    end
  end
end
