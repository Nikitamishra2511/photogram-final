class LikesController < ApplicationController
  def create
    @like = Like.new
    @like.photo_id = params.fetch(:photo_id)
    @like.fan_id = current_user.id

    if @like.save
      redirect_to photo_path(@like.photo_id), notice: "You liked the photo."
    else
      redirect_to photo_path(@like.photo_id), alert: "Unable to like photo."
    end
  end

  def destroy
    @like = Like.find_by(id: params.fetch(:id), fan_id: current_user.id)

    if @like
      @like.destroy
      redirect_to photo_path(@like.photo_id), alert: "You unliked the photo."
    else
      redirect_to photos_path, alert: "Unauthorized or already unliked."
    end
  end
end

