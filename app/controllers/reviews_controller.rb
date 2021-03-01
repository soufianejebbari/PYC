class ReviewsController < ApplicationController

  def index
    @review = Review.all(params[:cruise_id])
  end

  def new
    @cruise = Cruise.find(params[:cruise_id])
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @cruise = Cruise.find(params[:cruise_id])
    @review.cruise = @cruise
    if @review.save
      redirect_to cruise_path(@cruise)
    else
      render :new
    end
  end

  private

  def review_params
    params.require(:review).permit(:content, :rating)
  end

end
