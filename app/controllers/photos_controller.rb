class PhotosController < ApplicationController
  skip_before_action(:authenticate_user!, { :only => [:index, :show] })

  def index
    @list_of_photos = Photo.where({ :private => false })
    render({ :template => "photos/index" })
  end

  def new
    render({ :template => "photos/new" })
  end

  def create
    the_photo = Photo.new
    the_photo.owner_id       = session.fetch("user_id")
    the_photo.caption        = params.fetch("caption")
    the_photo.image          = params.fetch("image")
    the_photo.comments_count = 0
    the_photo.likes_count    = 0
    the_photo.save
    return redirect_to("/photos/#{ the_photo.id }", { :notice => "Photo added successfully." })
  end

  def show
    the_id         = params.fetch("an_id")
    matching_photos = Photo.where({ :id => the_id })
    @the_photo     = matching_photos.at(0)
    render({ :template => "photos/show" })
  end

  def edit
    the_id      = params.fetch("an_id")
    matching_photos = Photo.where({ :id => the_id })
    @photo      = matching_photos.at(0)
    render({ :template => "photos/edit" })
  end

  def update
    the_id         = params.fetch("an_id")
    matching_photos = Photo.where({ :id => the_id })
    the_photo      = matching_photos.at(0)
    the_photo.caption = params.fetch("caption")
    the_photo.image   = params.fetch("image")
    the_photo.save
    return redirect_to("/photos/#{ the_photo.id }", { :notice => "Photo updated successfully." })
  end

  def destroy
    the_id         = params.fetch("an_id")
    matching_photos = Photo.where({ :id => the_id })
    the_photo      = matching_photos.at(0)
    the_photo.destroy
    return redirect_to("/photos", { :notice => "Photo deleted successfully." })
  end

  def feed
    # your feed logic…
  end

  def discovery
    # your discovery logic…
  end
end
