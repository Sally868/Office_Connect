class BookingsController < ApplicationController
  before_action :set_booking, only: %i[ destroy ]
  before_action :set_venue, :set_space, only: %i[ new create ]

  def index
    @bookings = Booking.all
  end

  def show

  end

  # new_venue_space_booking GET/venues/:venue_id/spaces/:space_id/bookings/new(.:format)/bookings#new
  def new
    @booking = Booking.new
  end

  #  venue_space_bookings POST/venues/:venue_id/spaces/:space_id/bookings(.:format)/bookings#create
  def create
    @booking = Booking.new(booking_params)
    @booking.venue = 

    @booking.user = current_user
    if @booking.save
      redirect_to bookings_path
    else
      render :new
    end
  end

  def destroy
    @booking.destroy
    redirect_to bookings_path
  end


  private

  def set_venue
    @venue = Venue.find(params[:venue_id])
  end

  def set_space
    @space = Space.find(params[:space_id])
  end

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def booking_params
    params.require(:booking).permit(:venue_id, :space_id, :start, :finish)
  end
end
