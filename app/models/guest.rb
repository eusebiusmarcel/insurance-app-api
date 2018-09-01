class Guest < ApplicationRecord
    before_save { email.downcase! }

    scope :guests_by_product, -> (insurance_type) { where insurance_type: insurance_type }
    scope :search_name, -> (name) { where("lower(name) LIKE lower('%#{name}%')")}
    scope :search_email, -> (email) { where("lower(email) LIKE lower('#{email}%')")}
    validates :name, presence: true, length: { in: 3..50 }
    validates :email, presence: true, format: { with: EMAIL_REGEX },
                      uniqueness: { case_sensitive: false }
    validates :phone_number, presence: true, format: { with: PHONE_REGEX, message: Message.phone_regex }
    validates :insurance_type, inclusion: {
      in: ['Cyber Privacy Risk', 'Mobile & Tablet', 'Social Media Account'],
      message: 'Cyber Privacy Risk (0), Mobile & Tablet (1), atau Social Media Account (2)' }
    enum insurance_type: { 'Cyber Privacy Risk': 0, 'Mobile & Tablet': 1, 'Social Media Account': 2 }
    validates :city, inclusion: 
    { in: %w[Jakarta Bandung Yogyakarta Surabaya Bali],
      message: 'Jakarta, Bandung, Yogyakarta, Surabaya, atau Bali?' }
    enum city: { Jakarta: 'Jakarta', Bandung: 'Bandung', Yogyakarta: 'Yogyakarta', 
      Surabaya: 'Surabaya', Bali: 'Bali' }

end
