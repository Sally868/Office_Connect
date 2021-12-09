class BookingsController < ApplicationController
  before_action :set_booking, only: %i[destroy]
  before_action :set_space, only: %i[new create]
  skip_before_action :verify_authenticity_token, only: [:create]

  def index
    @bookings = Booking.all
  end

  def show
    @booking = Booking.where(params[:space_id])
  end

  # new_venue_space_booking GET /spaces/:space_id/bookings/new(.:format)/bookings#new
  def new
    @booking = Booking.new
    #  http://localhost:3000/spaces/5/bookings/new?week_start=2021-11-29T00%3A00%3A00%2B10%3A30
    if params[:week_start] && params[:week_start] > DateTime.now

      @monday = DateTime.parse(params[:week_start])
    else
      @monday = DateTime.now.beginning_of_week

    end

    @bookings = Booking.where('start >= ? and finish <= ?', @monday - 1.days, @monday + 7.days)
  end

  #  venue_space_bookings POST  /spaces/:space_id/bookings(.:format)/bookings#create
  def create
    @booking = Booking.new(booking_params)
    @booking.space = @space
    @booking.user = current_user
    if params[:week_start] && params[:week_start] > DateTime.now
      @monday = DateTime.parse(params[:week_start])
    else
      @monday = DateTime.now.beginning_of_week
    end
    
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
