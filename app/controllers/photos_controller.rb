class PhotosController < ApplicationController
  # Allow anyone to see the index; require sign-in for everything else
  skip_before_action(:authenticate_user!, { :only => [:index] })

  def index
    all_photos    = Photo.where({ })
    public_photos = []

    all_photos.each do |p|
      owner = User.where({ :id => p.owner_id }).at(0)
      next if owner.private
      public_photos.push(p)
    end

    @list_of_photos = public_photos
    render({ :template => "photos/index" })
  end

  def new
    render({ :template => "photos/new" })
  end

  def create
    the_photo                = Photo.new
    the_photo.owner_id       = current_user.id
    the_photo.caption        = params.fetch("caption")
    the_photo.image          = params.fetch("image")
    the_photo.comments_count = 0
    the_photo.likes_count    = 0
    the_photo.save

    return redirect_to(
      "/",
      { :notice => "Photo created successfully" }
    )
  end

  def show
    the_id         = params.fetch("an_id")
    matching_photos = Photo.where({ :id => the_id })
    @the_photo     = matching_photos.at(0)
    render({ :template => "photos/show" })
  end

  def edit
    the_id         = params.fetch("an_id")
    matching_photos = Photo.where({ :id => the_id })
    @the_photo     = matching_photos.at(0)
    render({ :template => "photos/edit" })
  end

  def update
    the_id         = params.fetch("an_id")
    matching_photos = Photo.where({ :id => the_id })
    the_photo      = matching_photos.at(0)
    the_photo.caption = params.fetch("caption")
    the_photo.image   = params.fetch("image")
    the_photo.save

    return redirect_to(
      "/",
      { :notice => "Photo updated successfully" }
    )
  end

  def destroy
    the_id         = params.fetch("an_id")
    matching_photos = Photo.where({ :id => the_id })
    the_photo      = matching_photos.at(0)
    the_photo.destroy

    return redirect_to(
      "/",
      { :notice => "Photo deleted successfully" }
    )
  end
end
