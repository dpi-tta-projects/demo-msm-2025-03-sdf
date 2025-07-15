class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @like = Like.new(like_params)
    @like.user = current_user

    respond_to do |format|
      if @like.save
        format.html { redirect_to(@like, { :notice => "Like created successfully." }) }
        format.js { render template: "likes/create" }
      else
        format.html { redirect_to(@like, { :error => "Unable to like this" }) }
        format.js { render template: "likes/create" }
      end
    end
  end

  def destroy
    @like = Like.find_by(id: params[:id])

    respond_to do |format|
      if @like.destroy
        format.html { redirect_to(@like.likeable, { :notice => "Like deleted successfully."} ) }
        format.js { render template: "likes/destroy" }
      else
        format.html { redirect_to(@like.likeable, { :error => "Unable to un-like this."} ) }
        format.js { render template: "likes/destroy" }
      end
    end

  end

  private

  def like_params
    params.require("like").permit(:likeable_id, :likeable_type)
  end
end
