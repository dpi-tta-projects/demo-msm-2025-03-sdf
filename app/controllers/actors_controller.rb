class ActorsController < ApplicationController
  def index
    # TODO：add pagination
    matching_actors = Actor.all.limit(10)

    @list_of_actors = matching_actors.order({ :created_at => :desc })

    render({ :template => "actors/index" })
  end

  def show
    @the_actor = Actor.find(params.fetch("id"))

    render({ :template => "actors/show" })
  end

  def new
    render({ :template => "actors/new" })
  end

  def create
    the_actor = Actor.new
    the_actor.dob = params.fetch("query_dob")
    the_actor.name = params.fetch("query_name")
    the_actor.bio = params.fetch("query_bio")

    if the_actor.valid?
      the_actor.save
      redirect_to("/actors", { :notice => "Actor created successfully." })
    else
      redirect_to("/actors", { :alert => the_actor.errors.full_messages.to_sentence })
    end
  end

  def edit
    @the_actor = Actor.find(params.fetch("id"))

    render({ :template => "actors/edit" })
  end

  def update
    the_id = params.fetch("id")
    the_actor = Actor.where({ :id => the_id }).at(0)

    the_actor.dob = params.fetch("query_dob")
    the_actor.name = params.fetch("query_name")
    the_actor.bio = params.fetch("query_bio")

    if the_actor.valid?
      the_actor.save
      redirect_to("/actors/#{the_actor.id}", { :notice => "Actor updated successfully."} )
    else
      redirect_to("/actors/#{the_actor.id}", { :alert => the_actor.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_actor = Actor.where({ :id => the_id }).at(0)

    the_actor.destroy

    redirect_to("/actors", { :notice => "Actor deleted successfully."} )
  end
end
