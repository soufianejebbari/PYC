class CruisesController < ApplicationController
  def new
    @cruise = Cruise.new
  end
end
