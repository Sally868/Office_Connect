class Venue < ApplicationRecord
  belongs_to :user
  has_many :spaces, dependent: :destroy
  has_many :bookings, through: :spaces

  geocoded_by :address do |obj,results|
    if geo = results.first
      obj.latitude    = geo.latitude
      obj.longitude    = geo.longitude
    end
  end

  after_validation :geocode

end
