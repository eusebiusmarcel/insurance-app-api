class ApplicationRecord < ActiveRecord::Base
  def initialize(*)
    super
  rescue ArgumentError
    raise if valid?
  end

  self.abstract_class = true

  EMAIL_REGEX = /\A[\w+\-.]+@(?!mailinator.com)[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  PHONE_REGEX = /\A(\()?(\+62|62)(\d{2,3})?\)?[ .-]?\d{3,4}[ .-]?\d{3,4}[ .-]?\d{1,4}\z/x
  ID_NUMBER_REGEX = /\A\d{16}+\z/
end
