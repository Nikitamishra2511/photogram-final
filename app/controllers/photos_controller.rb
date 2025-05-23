class PhotosController < ApplicationController
  skip_before_action(:authenticate_user!, { :only => [:index] })

  def index
    @list_of_photos = Photo.all
    render({ :template => "photos/index" })
  end

  def new
    render({ :template => "photos/new" })
  end

  def create
    the_photo           = Photo.new
    the_photo.user_id   = current_user.id
    the_photo.image     = params.fetch("image")
    the_photo.caption   = params.fetch("caption")
    the_photo.save

    redirect_to("/photos")
  end

  def show
    the_id       = params.fetch("an_id")
    @the_photo   = Photo.where({ :id => the_id }).at(0)
    render({ :template => "photos/show" })
  end

  def edit
    the_id       = params.fetch("an_id")
    @the_photo   = Photo.where({ :id => the_id }).at(0)
    render({ :template => "photos/edit" })
  end

  def update
    the_id       = params.fetch("an_id")
    the_photo    = Photo.where({ :id => the_id }).at(0)
    the_photo.image   = params.fetch("image")
    the_photo.caption = params.fetch("caption")
    the_photo.save

    redirect_to("/photos/" + the_id)
  end

  def destroy
    the_id       = params.fetch("an_id")
    the_photo    = Photo.where({ :id => the_id }).at(0)
    the_photo.destroy

    redirect_to("/photos")
  end
end
