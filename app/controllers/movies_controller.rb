class MoviesController < ApplicationController

  before_action :set_movie, only: [:show, :edit, :update, :destroy]
  before_action :require_user, except: [:index, :show]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def index
    @movies = Movie.paginate(page: params[:page], per_page: 5)
  end

  def show
    @comment = Comment.new
    @comments = @movie.comments.paginate(page: params[:page], per_page: 5)
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(movie_params)
    @movie.user = current_user
    if @movie.save
      flash[:success] = "Movie was created successfully!"
      redirect_to movie_path(@movie)
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @movie.update(movie_params)
      flash[:success] = "Movie was updated successfully!"
      redirect_to movie_path(@movie)
    else
      render 'edit'
    end
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:success] = "Movie deleted successfully"
    redirect_to movies_path
  end

  private

  def movie_params
    params.require(:movie).permit(:name, :description, genre_ids:[])
  end

  def set_movie
    @movie = Movie.find(params[:id])
  end

  def require_same_user
    if current_user != @movie.user and !current_user.admin?
      flash[:danger] = "You can only edit or delete your own movies"
      redirect_to movies_path
    end
  end
end
