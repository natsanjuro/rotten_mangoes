  class MoviesController < ApplicationController

  def index
    unless params[:search].blank?
      @movies = Movie.search(params[:search])
    else
      @movies = Movie.all
    end
    @movies = @movies.where("runtime_in_minutes <= ?", params[:run_time].to_i) unless params[:run_time].blank?
    @movies = @movies.order("release_date ASC")
  end

  # def index
  #   unless params[:search].blank?
  #     @movies = Movie.search(params[:search])
  #   else
  #     @movies = Movie.all
  #   end
  #   @movies = @movies.run_time(params[:run_time]) unless params[:run_time].blank?
  #   @movies = @movies.order("release_date ASC")
  # end


  # def index
  #   if params[:search].blank?
  #     @movies = Movie.search(params[:search])
  #   elsif params[:run_time].blank?
  #   @movies = @movies.run_time.to_i
  #   @movies = @movies.order("release_date ASC")
  #   else
  #     @movies = Movie.all
  #   end
  # end 

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
      :title, :release_date, :director, :runtime_in_minutes, :image, :description
    )
  end
  
end


