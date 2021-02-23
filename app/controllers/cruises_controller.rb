class CruisesController < ApplicationController
  def index
    @cruise = Cruise.all
  end

  def show
    @cruise = Cruise.find(params[:id])
    @booking = Booking.new
    authorize @cruise
  end

  def new
    @cruise = Cruise.new
    authorize @cruise
  end

  def create
    @cruise = Cruise.new(cruise_params)
    authorize @cruise
    if @cruise.save
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
    params.require(:cruise).permit(:start_date, :end_date, :price, :start_location, :end_location, :cruise_id)
  end
end
