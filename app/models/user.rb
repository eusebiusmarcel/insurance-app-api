class User < ApplicationRecord
  include PasswordManagement
  include ValidateGender
  include ValidateCity

  mount_uploader :avatar, AvatarUploader
  before_save { email.downcase! }
  has_secure_password

  has_many :policies
  has_many :claims

  scope :recently_created, -> { where("created_at > ?", Time.now - 10.minutes) }
  scope :users_by_product, -> (insurance_type) { includes(:policies).where(policies: { insurance_type: insurance_type }) }
  scope :search_name, -> (name) { where("lower(name) LIKE lower('%#{name}%')")}
  scope :search_email, -> (email) { where("lower(email) LIKE lower('#{email}%')")}

  enum gender: { P: 0, L: 1 }
  enum city: { Jakarta: 'Jakarta', Bandung: 'Bandung', Yogyakarta: 'Yogyakarta', 
    Surabaya: 'Surabaya', Bali: 'Bali' }

  validates :name, presence: true, length: { in: 3..50 }
  validates :email, presence: true, format: { with: EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { in: 6..30 }, allow_nil: true
  validates :id_card_number, presence: true, uniqueness: true, format: {
    with: ID_NUMBER_REGEX, message: 'terdiri dari 16 angka yang tertera di KTP' }
  validates :phone_number, presence: true, format: { with: PHONE_REGEX, message: Message.phone_regex }
  validates_presence_of :address, :place_of_birth, :date_of_birth

  validate :gender_should_be_valid
  validate :city_should_be_valid

  def as_json(*)
    super(except: %i[password_digest reset_password_token reset_password_token_sent_at],
          methods: :insurance_type)
  end

  def insurance_type
    insurance_type = []
    policies.each do |policy|
      insurance_type.push(policy.insurance_type) unless insurance_type.include?(policy.insurance_type)
    end
    insurance_type
  end

  class << self
    attr_accessor :created_users, :failed_to_create_users, :user
  end

  def self.import!(file)
    @created_users, @failed_to_create_users = Array.new(2) { [] }
    raise ExceptionHandler::AttributesNotComplete, Message.no_imported_file if file.blank?
    CSV.foreach(file.path, headers: true) do |row|
      @user = User.new(row.to_hash)
      user.email.downcase! unless user.email.blank?
      user.password = user.generate_token
      if user.save
        UserMailer.with(user: user).welcome.deliver
        created_users.push(user)
        remove_if_exist_in_guest
      else
        failed_to_create_users.push(user_email: user.email, errors: user.errors)
        next
      end
    end
  end

  private

  def self.remove_if_exist_in_guest
    guest = Guest.find_by(email: user.email)
    guest.destroy unless guest.blank?
  end
end
