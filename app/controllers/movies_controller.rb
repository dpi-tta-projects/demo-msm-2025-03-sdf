class MoviesController < ApplicationController
  def index
    matching_movies = Movie.all

    @list_of_movies = matching_movies.order({ :created_at => :desc })

    render({ :template => "movies/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_movies = Movie.where({ :id => the_id })

    @the_movie = matching_movies.at(0)

    render({ :template => "movies/show" })
  end

  def new
    # TODO: render template
  end

  def create
    the_movie = Movie.new
    the_movie.title = params.fetch("query_title")
    the_movie.year = params.fetch("query_year")
    the_movie.director_id = params.fetch("query_director_id")

    if the_movie.valid?
      the_movie.save
      redirect_to("/movies", { :notice => "Movie created successfully." })
    else
      redirect_to("/movies", { :alert => the_movie.errors.full_messages.to_sentence })
    end
  end

  def edit
    the_id = params.fetch("path_id")

    matching_movies = Movie.where({ :id => the_id })

    @the_movie = matching_movies.at(0)

    render({ :template => "movies/edit" })
  end

  def update
    the_id = params.fetch("path_id")
    @the_movie = Movie.where({ :id => the_id }).at(0)

    @the_movie.title = params.fetch("query_title")
    @the_movie.year = params.fetch("query_year")
    @the_movie.director_id = params.fetch("query_director_id")

    if @the_movie.valid?
      @the_movie.save
      redirect_to("/movies/#{@the_movie.id}", { :notice => "Movie updated successfully."} )
    else
      render({ :template => "movies/edit" })
      # redirect_to("/movies/#{the_movie.id}", { :alert => the_movie.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_movie = Movie.where({ :id => the_id }).at(0)

    the_movie.destroy

    redirect_to("/movies", { :notice => "Movie deleted successfully."} )
  end
end
