class BoatsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_boat, only: [:show, :edit, :update, :destroy]

  # def index
  #   # @boats = Boat.all
  #   if params[:search]
  #     if params[:search][:query].present?
  #       @boats = policy_scope(Boat).near(params[:search][:query], 5)
  #     else
  #       @boats = policy_scope(Boat)
  #     end
  #   else
  #     @boats = policy_scope(Boat)
  #   end
  # end

  def index
    @user = User.find(params[:user_id])
    @boats = Boat.where(user:@user)
    @boats = policy_scope(Boat)
  end

  def show
  end

  def new
    @boat = Boat.new
    authorize @boat
  end

  def create

    @boat = Boat.new(boat_params)
    @boat.user = current_user
    if @boat.save
      redirect_to user_path(current_user)
    else
      render :new
    end
    authorize @boat
  end

  def edit
    authorize @boat
  end

  def update
    if @boat.update(boat_params)
      redirect_to boat_path(@boat)
    else
      render :edit
    end
    authorize @boat
  end

  def destroy
    @boat.destroy
    redirect_to boats_path
    authorize @boat
  end

  private

  def boat_params
    params.require(:boat).permit(:name, :description, :category, :capacity, :user_id, photos: [])
  end

  def set_boat
    @boat = Boat.find(params[:user_id])
  end
end
