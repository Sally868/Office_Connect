class SpacesController < ApplicationController
   def index
    @venue = Venue.find(params[:venue_id])
    @spaces = Space.all
  end

  def show
  end

  def new
    @space= Space.new
    # authorize if owner -> yes. else no
  end

  def create
    @space= Space.new(space_params)
    @space.user = current_user
    if @space.save
      redirect_to @space
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
    redirect_to spaces_path
  end

  private

  def set_venue
    @space = Space.find(params[:id])

  end

  # Only allow a list of trusted parameters through.
  def venue_params
    params.require(:venue).permit(:name, :address)
  end
  # Use callbacks to share
end
