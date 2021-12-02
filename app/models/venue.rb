class Venue < ApplicationRecord
  belongs_to :user
  has_many :spaces, dependent: :destroy
  has_many :bookings, through: :spaces
  has_many_attached :photos
end
