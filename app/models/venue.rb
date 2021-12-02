class Venue < ApplicationRecord
  belongs_to :user
  has_many :spaces, dependent: :destroy
  has_many :bookings, through: :spaces

  geocoded_by :address do |obj, results|
    if geo = results.first
      obj.latitude = geo.latitude
      obj.longitude = geo.longitude
      obj.street = geo.street
      obj.suburb = geo.suburb
      obj.state = geo.state
      obj.country = geo.country
    end
  end

  after_validation :geocode
  has_many_attached :photos
<<<<<<< HEAD
=======
  
  geocoded_by :address do |obj,results|
    if geo = results.first
      obj.latitude = geo.latitude
      obj.longitude = geo.longitude
      obj.street = geo.street
      obj.suburb = geo.suburb
      obj.state = geo.state
      obj.country = geo.country
    end
  end
  after_validation :geocode
>>>>>>> dee6d5ba74968606d9fda1592f9a148afb7258af
end
