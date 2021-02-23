class BoatsController < ApplicationController
  # before_action :authenticate_user!
  before_action :set_boat, only: [:show, :edit, :update, :destroy]

  def index
    @boats = Boat.all
  end

  def show
  end

  def new
    # authorize @boat
    @boat = Boat.new
  end

  def create
    # authorize @boat
    @boat = Boat.new(boat_params)
    @boat.user = current_user
    if @boat.save
      redirect_to boat_path(@boat)
    else
      render :new
    end
  end

  def edit
  end

  def update
    # authorize @boat
    if @boat.update(boat_params)
      redirect_to boat_path(@boat)
    else
      render :edit
    end
  end

  def destroy
    # authorize @boat
    @boat.destroy
    redirect_to boats_path
  end

  private

  def boat_params
    params.require(:boat).permit(:name, :description, :category, :activity, :capacity)
  end

  def set_boat
    @boat = Boat.find(params[:id])
  end
end
