class Claim < ApplicationRecord
  belongs_to :policy
  enum status: { requirements_accepted: 0, on_process: 1, success: 2, rejected: 3 }
  validates :amount, presence: true
  validates :insurance_type, inclusion: {
    in: ['Requirements Accepted', 'On Process', 'Success', 'Rejected'],
    message: 'Requirements Accepted (0), On Process (1), Success (2), atau Rejected (3)' }
end
