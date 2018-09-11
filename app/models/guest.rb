class Guest < ApplicationRecord
  include ValidateInsuranceType
  include ValidateCity

  before_save { email.downcase! }

  scope :guests_by_product, -> (insurance_type) { where insurance_type: insurance_type }
  scope :search_name, -> (name) { where("lower(name) LIKE lower('%#{name}%')")}
  scope :search_email, -> (email) { where("lower(email) LIKE lower('#{email}%')")}

  enum insurance_type: { 'Cyber Privacy Risk': 0, 'Mobile & Tablet': 1, 'Social Media Account': 2 }
  enum city: { Jakarta: 'Jakarta', Bandung: 'Bandung', Yogyakarta: 'Yogyakarta', 
    Surabaya: 'Surabaya', Bali: 'Bali' }

  validates :name, presence: true, length: { in: 3..50 }
  validates :email, presence: true, format: { with: EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :phone_number, presence: true, format: { with: PHONE_REGEX, message: Message.phone_regex }

  validate :insurance_type_should_be_valid
  validate :city_should_be_valid

  def self.to_csv
    attributes = %w[name email phone_number insurance_type city]

    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.each do |guests|
        csv << guests.attributes.values_at(*attributes)
      end
    end
  end
end
