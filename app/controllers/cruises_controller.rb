class CruisesController < ApplicationController
  def index
    # @cruise = Cruise.all
    if params[:search]
      if params[:search][:query].present?
        @cruises = policy_scope(Cruise).near(params[:search][:query], 5)
      else
        @cruises = policy_scope(Cruise)
      end
    else
      @cruises = policy_scope(Cruise)
    end

    if params[:query].present?
      sql_query = " \
        cruises.name  @@ :query \
        OR boats.name @@ :query \
        OR cruises.start_location @@ :query \
        OR cruises.end_location @@ :query \
      "
      @cruises = Cruise.joins(:boat).where(sql_query, query: "%#{params[:query]}%")
    else
      @cruises = Cruise.all
    end
    @locations = Cruise.departure_locations
    @markers = @locations.map do |location|
      {
        lat: location.latitude,
        lng: location.longitude,
        infoWindow: render_to_string(partial: "info_window", locals: { location: location.cruises }),
        image_url: helpers.asset_url('marker_light.png')
      }
    end
  end

  def show
    @cruise = Cruise.find(params[:id])
    @booking = Booking.new
    authorize @cruise
    @locations = Location.where(cruise: @cruise)
    @markers = [Location.find(@cruise.start_location_id), Location.find(@cruise.end_location_id)].map do |location|
      {
        lat: location.latitude,
        lng: location.longitude,
        infoWindow: render_to_string(partial: "info_window", locals: { location: location.cruises }),
        image_url: helpers.asset_url('marker_light.png')
      }
    end
  end

  def new
    @cruise = Cruise.new
    authorize @cruise
  end

  def create
    @cruise = Cruise.new(cruise_params)
    authorize @cruise
    if @cruise.save
      flash[:alert] = "Congrats! Your cruise has been created!"
      redirect_to cruise_path(@cruise)
    else
      render :new
    end
  end

  def edit
    @cruise = Cruise.find(params[:id])
    authorize @cruise
  end

  def update
    @cruise = Cruise.find(params[:id])
    authorize @cruise
    if @cruise.update(cruise_params)
      redirect_to @cruise
    else
      render :edit
    end
  end

  private

  def cruise_params
    params.require(:cruise).permit(:name, :description, :start_date, :end_date, :price, :start_location_id, :end_location_id, :difficulty, :boat_id)
  end
end
