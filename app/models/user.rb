class User < ApplicationRecord
  acts_as_token_authenticatable

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :venues, dependent: :destroy
  has_many :venue_bookings, :through => :venues, :source => :bookings
  has_many :bookings, dependent: :destroy
end
