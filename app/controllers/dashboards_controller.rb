class DashboardsController < ApplicationController
  def show
    @venues = current_user.venues
    @venue_bookings = current_user.venue_bookings
    @my_bookings = current_user.bookings
  end
end
