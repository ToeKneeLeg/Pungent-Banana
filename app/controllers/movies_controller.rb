class MoviesController < ApplicationController

  def index
    @movies = Movie.all

    @movies = Movie.search_by_title(params[:q]) unless params[:q].blank?
    
    # @movies = Movie.search_by_director(params[:r]) unless params[:r].blank?

    if params[:duration].to_i == 1
      @movies = Movie.search_shorter_than_90
    end
    if params[:duration].to_i == 2
      @movies = Movie.search_between_90_120
    end
    if params[:duration].to_i == 3
      @movies = Movie.search_longer_than_120
    end
  end

  def show
    @movie = Movie.find(params[:id])
  end

  def new
    @movie = Movie.new
  end

  def edit
    @movie = Movie.find(params[:id])
  end
  
  def create
    @movie = Movie.new(movie_params)

    if @movie.save
      redirect_to movies_path, notice: "#{@movie.title} was submitted successfully!"
    else
      render :new
    end
  end

  def update
    @movie = Movie.find(params[:id])

    if @movie.update_attributes(movie_params)
      redirect_to movie_path(@movie)
    else
      render :edit
    end
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    redirect_to movies_path
  end

  protected

  def movie_params
    params.require(:movie).permit(
      :title, :release_date, :director, :runtime_in_minutes, :poster_image_url, :description, :image, :remote_image_url
    )
  end
end
