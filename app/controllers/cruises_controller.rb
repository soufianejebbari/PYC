class CruisesController < ApplicationController
  def index
    # @cruise = Cruise.all
    if params[:search]
      if params[:search][:query].present?
        @locations = policy_scope(Location).near(params[:search][:query], 5)
      else
        @locations = policy_scope(Location)
      end
    else
      @locations = policy_scope(Location)
    end

    if params[:query].present?
      sql_query = " \
        cruises.name  @@ :query \
        OR boats.name @@ :query \
        OR boats.category @@ :query \
        OR locations.name @@ :query \
      "
      @cruises = Cruise.joins(:boat).joins(:location).where(sql_query, query: "%#{params[:query]}%")
    else
      @cruises = Cruise.all
    end

    # @location = location.near(params[:search])
    # @cruises = Cruise.where(start_location = location)
    # @cruises = locations.map { |location| Cruise.where(start_location: location) }.flatten
    # find locatiojns closde to search -> locations = Location.near(search)
    # for each location find cruises that starts here -> cruises = Cruise.where(start_location = location)
    # cruises = locations.map{|location| Cruise.where(start_location: location)}.flatten

    @locations = Cruise.departure_locations
    @markers = @locations.map do |location|
      {
        lat: location.latitude,
        lng: location.longitude,
        infoWindow: render_to_string(partial: "info_window", locals: { location: location.cruises }),
        image_url: helpers.asset_url('marker_dark.png')
      }
    end
  end

  def show
    @cruise = Cruise.find(params[:id])
    @booking = Booking.new
    authorize @cruise
    @locations = Location.where(cruise: @cruise)
    markers_bg = {
      start_location: 'marker_dark.png',
      stop: 'logo_light.png',
      end_location: 'marker_light.png'
    }
    @markers = @cruise.stops.map do |stop|
      bg = ''
      if stop.start_location
        bg = markers_bg[:start_location]
      elsif stop.end_location
        bg = markers_bg[:end_location]
      else
        bg = markers_bg[:stop]
      end
      {

        lat: stop.location.latitude,
        lng: stop.location.longitude,
        infoWindow: render_to_string(partial: "info_window", locals: { location: stop.location.cruises }),
        image_url: helpers.asset_url(bg)
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
    params.require(:cruise).permit(:name, :description, :start_date, :end_date, :price, :start_location, :end_location, :difficulty, :boat_id)
  end
end
