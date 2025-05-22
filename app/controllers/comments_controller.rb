class CommentsController < ApplicationController
  def create
    @comment = Comment.new
    @comment.photo_id = params[:photo_id]
    @comment.author_id = current_user.id
    @comment.body = params[:body]

    if @comment.save
      redirect_to photo_path(@comment.photo), notice: "Comment posted successfully."
    else
      redirect_to photo_path(@comment.photo), alert: "Failed to post comment."
    end
  end
end
