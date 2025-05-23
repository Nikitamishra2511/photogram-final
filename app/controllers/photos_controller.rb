class PhotosController < ApplicationController
  skip_before_action(:authenticate_user!, { :only => [:index, :show] })

  def index
    all_photos    = Photo.all
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
    the_photo                  = Photo.new
    the_photo.owner_id         = session.fetch("user_id")
    the_photo.caption          = params.fetch("caption")
    the_photo.image            = params.fetch("image")
    the_photo.comments_count   = 0
    the_photo.likes_count      = 0
    the_photo.save

    return redirect_to("/photos/#{ the_photo.id }",
                       { :notice => "Photo added successfully." })
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

    return redirect_to("/photos/#{ the_photo.id }",
                       { :notice => "Photo updated successfully." })
  end

  def destroy
    the_id         = params.fetch("an_id")
    matching_photos = Photo.where({ :id => the_id })
    the_photo      = matching_photos.at(0)
    the_photo.destroy

    return redirect_to("/photos", { :notice => "Photo deleted successfully." })
  end

  # feed & discovery live in UsersController
end
