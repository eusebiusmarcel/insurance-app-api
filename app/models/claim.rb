class Claim < ApplicationRecord
  belongs_to :policy
  belongs_to :user
  enum status: { 'Requirements Accepted': 0, 'On Process': 1, 'Success': 2, 'Rejected': 3 }
  validates :amount, presence: true
  validates :status, inclusion: {
    in: ['Requirements Accepted', 'On Process', 'Success', 'Rejected'],
    message: 'Requirements Accepted (0), On Process (1), Success (2), or Rejected (3)' },
    on: :change_status
end
