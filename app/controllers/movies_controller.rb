class MoviesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_movie, only: [:show, :edit, :update, :destroy]
  before_action :authorize_movie

  def index
    @q = Movie.ransack(params[:q])
    @movies = @q.result.order({ :created_at => :desc }).page(params[:page])

    @breadcrumbs = [
      {content: "Movies"}
    ]
  end

  def show
    @breadcrumbs = [
      {content: "Movies", href: movies_path},
      {content: @movie.to_s}
    ]

    render({ :template => "movies/show" })
  end

  def new
    @movie = Movie.new

    @breadcrumbs = [
      {content: "Movies", href: movies_path},
      {content: "New"}
    ]

    render({ :template => "movies/new" })
  end

  def create
    # @movie = current_user.authored_movies.new(movie_params)
    @movie = Movie.new(movie_params)
    @movie.author = current_user

    if @movie.valid?
      @movie.save
      redirect_to(@movie, { :notice => "Movie created successfully." })
    else
      render({ :template => "movies/new" })
    end
  end

  def edit
    @breadcrumbs = [
      {content: "Movies", href: movies_path},
      {content: @movie.to_s, href: movie_path(@movie)},
      {content: "Edit"}
    ]

    render({ :template => "movies/edit" })
  end

  def update
    @breadcrumbs = [
      {content: "Movies", href: movies_path},
      {content: @movie.to_s, href: movie_path(@movie)},
      {content: "Edit"}
    ]
    if @movie.update(movie_params)
      redirect_to("/movies/#{@movie.id}", { :notice => "Movie updated successfully."} )
    else
      render({ :template => "movies/edit" })
    end
  end

  def destroy
    @movie.destroy
    redirect_to("/movies", { :notice => "Movie deleted successfully."} )
  end

  private

  def movie_params
    params.require("movie").permit(:title, :year, :director_id, :image)
  end

  def set_movie
    @movie = Movie.find(params.fetch("id"))
  end

  def authorize_movie
    authorize(@movie || Movie)
  end
end
