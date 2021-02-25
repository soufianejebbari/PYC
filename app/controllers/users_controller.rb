class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    authorize @user
  end

  def new
    @user = User.new
  end

  def create
  end

  # private

  # def user_params
  #   params.require(:user).permit(:email, :photo)
  # end

end
