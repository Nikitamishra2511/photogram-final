class CommentsController < ApplicationController
  def create
    unless user_signed_in?
      redirect_to root_path, alert: "You must be signed in to comment."
      return
    end

    @comment = Comment.new(comment_params)
    @comment.author = current_user

    if @comment.save
      redirect_to photo_path(@comment.photo), notice: "Comment added"
    else
      redirect_to photo_path(@comment.photo), alert: @comment.errors.full_messages.to_sentence
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
    redirect_to photo_path(comment.photo), notice: "Comment deleted"
  end

  private

  def comment_params
    params.require(:comment).permit(:photo_id, :body)
  end
end

