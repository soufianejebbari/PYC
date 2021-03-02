class CruisesController < ApplicationController
  def index
    # @cruise = Cruise.all
    if params[:search]
      if params[:search][:query].present?
        locations = policy_scope(Location).near(params[:search][:query], 100)
        @cruises = locations.map { |location| location.cruises }.flatten
      else
        @cruises = policy_scope(Cruise)
      end
    else
      @cruises = policy_scope(Cruise)
    end

    @locations = @cruises.map(&:start_location)
    @markers = @locations.map do |location|
      {
        lat: location.latitude,
        lng: location.longitude,
        infoWindow: render_to_string(partial: "info_window", locals: { location: location.cruises }),
        image_url: helpers.asset_url('marker_green.png')
      }
    end
  end

  def show
    @cruise = Cruise.find(params[:id])
    @booking = Booking.new
    authorize @cruise
    @locations = Location.where(cruise: @cruise)
    markers_bg = {
      start_location: 'marker_green.png',
      stop: 'marker_dark.png',
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
    @seat_booked = 0
    Booking.where(cruise: @cruise).each do |booking|
     @seat_booked += booking.seats
    end
    @booking_capacity = @cruise.boat.capacity - @seat_booked
  end

  def new
    @cruise = Cruise.new
    authorize @cruise
  end

  def create
    @cruise = Cruise.new(cruise_params)

    authorize @cruise
    if @cruise.save
      start_loc = Stop.create(location: Location.find(params[:cruise][:start_location]), cruise: @cruise, start_location: true)
      end_loc = Stop.create(location: Location.find(params[:cruise][:end_location]), cruise: @cruise, end_location: true)
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
    params.require(:cruise).permit(:name, :description, :start_date, :end_date, :end_date, :price, :difficulty, :boat_id)
  end

  def start_location_param
    params.require(:cruise).permit(:start_location, :end_location)
  end
end
