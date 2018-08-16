class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  EMAIL_REGEX = /\A[\w+\-.]+@(?!mailinator.com)[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  NAME_REGEX = /[a-zA-Z]/
end
