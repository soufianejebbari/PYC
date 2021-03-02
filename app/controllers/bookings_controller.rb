class BookingsController < ApplicationController
  def new
    @cruise = Cruise.find(params[:cruise_id])
    @booking = Booking.new
  end

  def create
    @cruise = Cruise.find(params[:cruise_id])
    @booking = Booking.new(booking_params)
    @booking.user = current_user
    @booking.cruise = @cruise
    @seats = booking_params[:seats]
    authorize @booking

    if @booking.save
      flash[:alert] = "Congrats! You have booked this board"
      redirect_to dashboard_path
    else
      render "cruises/show"
    end
  end

  def booking_params
    params.require(:booking).permit(:user_id, :cruise_id, :seats)
  end
end
