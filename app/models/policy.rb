class Policy < ApplicationRecord
  mount_uploader :document_url, PolicyDocumentUploader
  belongs_to :user
  has_many :payment_details
  before_save{ email.downcase! }
  validates :email, presence: true, format: { with: EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  before_save{ policy_number.upcase! }
  paginates_per 10

  validates :policy_number, presence: true, uniqueness: { case_sensitive: false },
                            format: { with: POLICY_NUMBER_REGEX, message: Message.policy_number_regex }
  validates_presence_of :insured_item, :premium_per_month, :limit_per_year, :balance
  validates :payment_due_date, presence: true, inclusion: { 
    in: 1..28, message: 'pilih tanggal 1 sampai 28' }
  validates :insurance_type, inclusion: {
    in: ['Cyber Privacy Risk', 'Mobile & Tablet', 'Social Media Account'],
    message: 'Cyber Privacy Risk (0), Mobile & Tablet (1), atau Social Media Account (2)' }
  enum insurance_type: { 'Cyber Privacy Risk': 0, 'Mobile & Tablet': 1, 'Social Media Account': 2 }
  enum status: { active: 0, inactive: 1 }

  def self.import!(file)
      @@created_policies, @@failed_to_created_policies = Array.new(2) { [] }
    CSV.foreach(file.path, headers: true) do |row|
      params = row.to_hash
      user = User.find_by(email: params[:email].downcase!)
      policy = user.policies.new(row.to_hash)
      if policy.save
        @@created_policies.push(policy)
      else
        @@failed_to_created_policies.push(policy)
        next
      end
    end
  end

  def self.created_policies
    @@created_policies
  end

  def self.failed_to_created_policies
    @@failed_to_created_policies
  end
end
