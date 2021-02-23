class CruisesController < ApplicationController
  def index
    @cruise = Cruise.all
  end

  def show
    @cruise = Cruise.find(params[:id])
    @booking = Booking.new
  end

  def new
    @cruise = Cruise.new
  end

  def create
    @cruise = Cruise.new(cruise_params)
    if @cruise.save
      redirect_to cruise_path(@cruise)
    else
      render :new
    end
  end

  def edit
    @cruise = Cruise.find(params[:id])
  end

  def update
    @cruise = Cruise.find(params[:id])
    if @cruise.update(cruise_params)
      redirect_to @cruise
    else
      render :edit
    end
  end

  private

  def cruise_params
    params.require(:cruise).permit(:start_date, :end_date, :price, :start_location, :end_location, :cruise_id)
  end
end
