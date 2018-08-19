class ApplicationRecord < ActiveRecord::Base
  def initialize(*)
    super
  rescue ArgumentError
    raise if valid?
  end

  self.abstract_class = true

  EMAIL_REGEX = /\A[\w+\-.]+@(?!mailinator.com)[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  PHONE_REGEX = /\A(\()?(\+62|62|0)(\d{2,3})?\)?[ .-]?\d{2,3}[ .-]?\d{2,3}[ .-]?\d{2,3}\z/x
  ID_NUMBER_REGEX = /\A\d{16}+\z/
end
