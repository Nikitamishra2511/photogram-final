class LikesController < ApplicationController
  def create
    @like = Like.new
    @like.photo_id = params[:photo_id]
    @like.fan_id = current_user.id

    if @like.save
      redirect_to photo_path(@like.photo), notice: "Like created successfully."
    else
      redirect_to photo_path(@like.photo), alert: "Like failed to save."
    end
  end

  def destroy
    @like = Like.find(params[:id])

    if @like.fan_id == current_user.id
      @like.destroy
      redirect_to photo_path(@like.photo), alert: "Like deleted successfully."
    else
      redirect_to photo_path(@like.photo), alert: "You are not authorized to unlike this photo."
    end
  end
end
