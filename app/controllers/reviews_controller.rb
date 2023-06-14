class ReviewsController < ApplicationController
  def create
     @user = current_user.id
     @movie = Movie.find(params[:movie_id])
    @review =@movie.reviews.create(review_params)
    redirect_to movie_path(@movie)
  end
 
  private
    def review_params
      params.require(:review).permit(:star, :body)
    end
end

