class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  EMAIL_REGEX = /\A[\w+\-.]+@(?!mailinator.com)[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  PHONE_REGEX = /(\()?(\+62|62|0)(\d{2,3})?\)?[ .-]?\d{2,4}[ .-]?\d{2,4}[ .-]?\d{2,4}/x
end
