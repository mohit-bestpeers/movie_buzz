class MoviesController < ApplicationController
  before_action :authenticate_user! ,only: [:create,:edit,:destroy,:update]
  
  def index
    @movies =  Movie.paginate(page: params[:page], per_page: 4)
  end

  def show
    @movie = Movie.find(params[:id])
  end

  def new
    @movie = Movie.new
  end

  def create 
    @movie = current_user.movies.new(movie_params)
    if @movie.save
      redirect_to @movie,
      notice: "Successfully created movie!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  def update
    @movie = Movie.find(params[:id])

    if @movie.update(movie_params)
      redirect_to @movie,
      notice: "Successfully Updated your Movie Name!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy

    redirect_to root_path, status: :see_other,
    notice: "Successfully Deleted Movie!"
  end
  
  def upcomming
    @movies = Movie.where("released_on > ?",Date.today)
  end

  def popular_movie
    @popular_movies = Movie.where("rating >= 3.5")
  end

  private
  
  def movie_params
    params.require(:movie).permit(:name,:rating,:description,:director,:released_on,:image)
  end
 
end
