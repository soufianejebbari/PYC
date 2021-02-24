class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
  end
end
