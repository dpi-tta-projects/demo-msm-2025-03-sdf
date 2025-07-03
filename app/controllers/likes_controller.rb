class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @like = Like.new(like_params)
    @like.user = current_user

    if @like.valid?
      @like.save
      redirect_to(@like, { :notice => "Like created successfully." })
    else
      # TODO: change this wording
      flash[:error] = "Unable to like this"
    end
  end

  def destroy
    like = Like.find_by(id: params[:id])
    like.destroy
    redirect_to(like.likeable, { :notice => "Like deleted successfully."} )
  end

  private

  def like_params
    params.require("like").permit(:likeable_id, :likeable_type)
  end
end
