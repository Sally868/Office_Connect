class VenuesController < ApplicationController
  before_action :set_venue, only: %i[show edit update destroy]
  def index
    @venues = Venue.all
    ::WebpushNotification.publish_user_action(
      user: current_user,
      title: "test",
      action: "Added"
    )
  end

  def show
    @spaces = @venue.spaces
  end

  def new
    @venue = Venue.new
    # authorize if owner -> yes. else no
  end

  def create
    @venue = Venue.new(venue_params)
    @venue.user = current_user
    if @venue.save
      redirect_to new_venue_space_path(@venue)
    else
      render :new
    end
  end

  def edit
    # authorize if owner -> yes. else no
  end

  def update
    if @venue.update(venue_params)
      redirect_to @venue, notice: 'Venue was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    # authorize if owner -> yes. else no
    @venue.destroy
    redirect_to venues_path
  end

  private

  def set_venue
    @venue = Venue.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def venue_params
    params.require(:venue).permit(:name, :address, photos: [])
  end
  # Use callbacks to share
end
