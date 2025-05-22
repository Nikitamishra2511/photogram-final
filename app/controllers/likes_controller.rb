class LikesController < ApplicationController
  def create
    @like = Like.new
    @like.fan_id = current_user.id
    @like.photo_id = params.fetch("photo_id")

    if @like.save
      redirect_to photo_path(@like.photo_id), notice: "Like added successfully."
    else
      redirect_to photo_path(@like.photo_id), alert: "Failed to add like."
    end
  end

  def destroy
    like = Like.find(params[:id])
    like.destroy

    redirect_to photo_path(like.photo_id), alert: "Like removed successfully."
  end
end

