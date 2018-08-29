class User < ApplicationRecord
  require 'csv'
  include PasswordManagement
  mount_uploader :avatar, AvatarUploader
  
  scope :recently_created, -> { where("created_at > ?", Time.now - 10.minutes) }

  before_save { email.downcase! }
  has_secure_password
  has_many :policies
  validates :name, presence: true, length: { in: 3..50 }
  validates :email, presence: true, format: { with: EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { in: 6..30 }, allow_nil: true
  validates :id_card_number, presence: true, uniqueness: true, format: {
    with: ID_NUMBER_REGEX, message: 'terdiri dari 16 angka yang tertera di KTP' }
  validates :gender, inclusion: {
    in: %w[P L], message: 'perempuan (P) atau laki-laki (L)? Masukkan L/P' }
  enum gender: { P: 0, L: 1 }
  validates :phone_number, presence: true, format: { with: PHONE_REGEX, message: Message.phone_regex }
  validates_presence_of :address, :place_of_birth, :date_of_birth
  validates :city, inclusion: 
  { in: %w[Jakarta Bandung Yogyakarta Surabaya Bali],
    message: 'Jakarta, Bandung, Yogyakarta, Surabaya, atau Bali?' }
  enum city: { Jakarta: 'Jakarta', Bandung: 'Bandung', Yogyakarta: 'Yogyakarta', 
               Surabaya: 'Surabaya', Bali: 'Bali' }

  def self.import!(file)
    @@created_users, @@failed_to_create_users = Array.new(2) { [] }
    CSV.foreach(file.path, headers: true) do |row|
      user = User.new(row.to_hash)
      user.email.downcase! unless user.email.blank?
      user.password = user.generate_token
      if user.save
        UserMailer.with(user: user).welcome.deliver
        @@created_users.push(user)
      else
        @@failed_to_create_users.push(user_email: user.email, errors: user.errors)
        next
      end
    end
  end

  def self.created_users
    @@created_users
  end

  def self.failed_to_create_users
    @@failed_to_create_users
  end
end
