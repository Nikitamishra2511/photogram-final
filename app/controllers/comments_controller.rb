class CommentsController < ApplicationController
  def index
    @list_of_comments = Comment.all
    render({ :template => "comments/index" })
  end

  def new
    render({ :template => "comments/new" })
  end

  def create
    the_comment           = Comment.new
    the_comment.author_id = current_user.id
    the_comment.photo_id  = params.fetch("photo_id")
    the_comment.body      = params.fetch("body")
    the_comment.save

    redirect_to("/photos/" + the_comment.photo_id.to_s)
  end

  def show
    the_id          = params.fetch("an_id")
    @the_comment    = Comment.where({ :id => the_id }).at(0)
    render({ :template => "comments/show" })
  end

  def edit
    the_id          = params.fetch("an_id")
    @the_comment    = Comment.where({ :id => the_id }).at(0)
    render({ :template => "comments/edit" })
  end

  def update
    the_id          = params.fetch("an_id")
    the_comment     = Comment.where({ :id => the_id }).at(0)
    the_comment.body= params.fetch("body")
    the_comment.save

    redirect_to("/comments/" + the_id)
  end

  def destroy
    the_id          = params.fetch("an_id")
    the_comment     = Comment.where({ :id => the_id }).at(0)
    the_comment.destroy

    redirect_to("/comments")
  end
end
