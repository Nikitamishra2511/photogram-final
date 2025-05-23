class LikesController < ApplicationController
  def index
    @list_of_likes = Like.all
    render({ :template => "likes/index" })
  end

  def new
    render({ :template => "likes/new" })
  end

  def create
    the_like          = Like.new
    the_like.fan_id   = current_user.id
    the_like.photo_id = params.fetch("photo_id")
    the_like.save

    redirect_to("/photos/" + the_like.photo_id.to_s)
  end

  def show
    the_id       = params.fetch("an_id")
    @the_like    = Like.where({ :id => the_id }).at(0)
    render({ :template => "likes/show" })
  end

  def edit
    the_id       = params.fetch("an_id")
    @the_like    = Like.where({ :id => the_id }).at(0)
    render({ :template => "likes/edit" })
  end

  def update
    the_id       = params.fetch("an_id")
    the_like     = Like.where({ :id => the_id }).at(0)
    the_like.photo_id = params.fetch("photo_id")
    the_like.save

    redirect_to("/likes/" + the_id)
  end

  def destroy
    the_id       = params.fetch("an_id")
    the_like     = Like.where({ :id => the_id }).at(0)
    the_like.destroy

    redirect_to("/likes")
  end
end
