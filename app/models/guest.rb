class Guest < ApplicationRecord
    scope :guests_by_product, -> (insurance_type) { where insurance_type: insurance_type }
    
    validates :name, presence: true, length: { in: 3..50 }
    validates :email, presence: true, format: { with: EMAIL_REGEX }     
    validates :phone_number, presence: true, format: { with: PHONE_REGEX }
    validates :insurance_type, inclusion: {
        in: %w[cyber_privacy_risk mobile_tablet social_media_account],
        message: 'cyber_privacy_risk (0), mobile_tablet (1), atau social_media_account (2)' }
    enum insurance_type: { cyber_privacy_risk: 0, mobile_tablet: 1, social_media_account: 2 }

    validates :city, inclusion: 
    { in: %w[Jakarta Bandung Yogyakarta Surabaya Bali],
      message: 'Jakarta, Bandung, Yogyakarta, Surabaya, atau Bali?' }
    enum city: { Jakarta: 'Jakarta', Bandung: 'Bandung', Yogyakarta: 'Yogyakarta', 
        Surabaya: 'Surabaya', Bali: 'Bali' }
    
        
end
