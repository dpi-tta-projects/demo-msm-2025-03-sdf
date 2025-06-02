class MoviesController < ApplicationController
  def index
    @movies = Movie.order({ :created_at => :desc }).page(params[:page])
  end

  def show
    the_id = params.fetch("id")

    matching_movies = Movie.where({ :id => the_id })

    @movie = matching_movies.at(0)

    render({ :template => "movies/show" })
  end

  def new
    @movie = Movie.new

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
    the_id = params.fetch("id")

    matching_movies = Movie.where({ :id => the_id })

    @movie = matching_movies.at(0)

    render({ :template => "movies/edit" })
  end

  def update
    the_id = params.fetch("id")
    @movie = Movie.where({ :id => the_id }).at(0)

    if @movie.update(movie_params)
      redirect_to("/movies/#{@movie.id}", { :notice => "Movie updated successfully."} )
    else
      render({ :template => "movies/edit" })
    end
  end

  def destroy
    the_id = params.fetch("id")
    movie = Movie.where({ :id => the_id }).at(0)

    movie.destroy

    redirect_to("/movies", { :notice => "Movie deleted successfully."} )
  end

  private

  def movie_params
    params.require("movie").permit(:title, :year, :director_id)
  end
end
