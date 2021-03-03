class PagesController < ApplicationController
  def home
  end

  def dashboard
    @user = current_user
    @bookings = @user.bookings
    @boat = Boat.new
    # @bookings = @user.bookings
    # @boats = @user.boats
  end
end
