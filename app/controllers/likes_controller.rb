class LikesController < ApplicationController
  def create
    like = Like.new
    like.fan_id = current_user.id
    like.photo_id = params.fetch("photo_id")

    if like.save
      redirect_to photo_path(like.photo), notice: "Like added"
    else
      redirect_to photo_path(like.photo), alert: like.errors.full_messages.to_sentence
    end
  end

  def destroy
    like = Like.find(params[:id])
    like.destroy
    redirect_to photo_path(like.photo), notice: "Like removed"
  end
end
