class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :space

  validates :start, presence: true
  validates :finish, presence: true
end
