class CommentsController < ApplicationController
  def create
    @comment = Comment.new
    @comment.body = params.fetch(:body)
    @comment.photo_id = params.fetch(:photo_id)
    @comment.author_id = current_user.id

    if @comment.save
      redirect_to photo_path(@comment.photo_id), notice: "Comment added."
    else
      redirect_to photo_path(@comment.photo_id), alert: "Unable to add comment."
    end
  end

  def destroy
    @comment = Comment.find(params.fetch(:id))

    if @comment.author_id == current_user.id
      @comment.destroy
      redirect_to photo_path(@comment.photo_id), alert: "Comment deleted."
    else
      redirect_to photo_path(@comment.photo_id), alert: "Unauthorized action."
    end
  end
end
