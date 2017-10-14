class GenresController < ApplicationController

  before_action :set_genre, only: [:edit, :update, :show]
  before_action :require_admin, except: [:show, :index]

  def new
    @genre = Genre.new
  end

  def create
    @genre = Genre.new(genre_params)
    if @genre.save
      flash[:success] = "Genre was successfully created"
      redirect_to genre_path(@genre)
    else
      render 'new'
    end
  end

  def edit

  end

  def update
    if @genre.update(genre_params)
      flash[:success] = "Genre name was updated successfully"
      redirect_to @genre
    else
      render 'edit'
    end
  end

  def show
    @genre_movies = @genre.movies.paginate(page: params[:page], per_page:5)
  end

  def index
    @genres = Genre.paginate(page: params[:page], per_page: 5)
  end

  private

  def genre_params
    params.require(:genre).permit(:name)
  end

  def set_genre
    @genre = Genre.find(params[:id])
  end

  def require_admin
    if !logged_in? || (logged_in? and !current_user.admin?)
      flash[:danger] = "Only admin users can perform that action"
      redirect_to genres_path
    end
  end

end
