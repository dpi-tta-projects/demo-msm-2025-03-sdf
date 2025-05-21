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
    @actor = Actor.new
    render({ :template => "actors/new" })
  end

  def create
    @actor = Actor.new(actor_params)

    if @actor.save
      redirect_to(actor_path(@actor), notice: "Actor created successfully.")
    else
      render :new
    end
  end

  def edit
    @actor = Actor.find(params.fetch("id"))

    render({ :template => "actors/edit" })
  end

  def update
    @actor = Actor.find(params.fetch("id"))

    if @actor.update(actor_params)
      redirect_to("/actors/#{the_actor.id}", { :notice => "Actor updated successfully."} )
    else
      render :edit
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_actor = Actor.where({ :id => the_id }).at(0)

    the_actor.destroy

    redirect_to("/actors", { :notice => "Actor deleted successfully."} )
  end

  private

  def actor_params
    params.require(:actor).permit(:dob, :name, :bio)
  end
end
