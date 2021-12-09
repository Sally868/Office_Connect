class SpacesController < ApplicationController
  before_action :set_space, only: %i[show edit update destroy]
  def index
    @venue = Venue.find(params[:venue_id])
    @spaces = Space.all
  end

  def show
    def all
      booking = Booking.order(date: :asc)
     end
  end

  def new
    @venue = Venue.find(params[:venue_id])
    @space = Space.new
    # authorize if owner -> yes. else no
  end

  def create
    @space = Space.new(space_params)
    @venue = Venue.find(params[:venue_id])
    @space.venue = @venue
    if @space.save
      redirect_to venue_path(@venue)
    else
      render :new
    end
  end

  def edit
    # authorize if owner -> yes. else no
  end

  def update
    if @space.update(space_params)
      redirect_to @space, notice: 'Space was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    # authorize if owner -> yes. else no
    @space.destroy
    redirect_to venue_path(@space.venue)
  end

  private

  def set_space
    @space = Space.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def space_params
    params.require(:space).permit(:name, :capacity, :photo, :description)
  end
  # Use callbacks to share
end
