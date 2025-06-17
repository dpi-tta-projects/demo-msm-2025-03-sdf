class MoviesController < ApplicationController
  before_action :set_movie, only: [:show, :edit, :update, :destroy]

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
    @movie = Movie.new(movie_params)

    if @movie.valid?
      @movie.save
      # TODO: redirect to movies#show
      redirect_to("/movies", { :notice => "Movie created successfully." })
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
    params.require("movie").permit(:title, :year, :director_id)
  end

  def set_movie
    @movie = Movie.find(params.fetch("id"))
  end
end
