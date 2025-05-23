class PhotosController < ApplicationController
  # Allow public access to index, require sign-in for everything else
  skip_before_action :ensure_signed_in, only: [:index]
  before_action :ensure_signed_in, except: [:index]

  def index
    # Only show photos from users who are not private
    @photos = Photo
      .joins(:owner)
      .where(users: { private: false })
      .order(created_at: :desc)

    render({ template: "photos/index" })
  end

  def show
    @photo = Photo.find(params.fetch("id"))
    @comments = Comment.where(photo_id: @photo.id)

    @like = Like.where(photo_id: @photo.id, fan_id: current_user&.id).first

    render({ template: "photos/show" })
  end

  def new
    @photo = Photo.new
    render({ template: "photos/new" })
  end

  def create
    the_photo = Photo.new
    the_photo.caption = params.fetch("caption")
    the_photo.image = params.fetch("image")
    the_photo.owner_id = current_user.id
    the_photo.comments_count = 0
    the_photo.likes_count = 0

    if the_photo.save
      flash[:notice] = "Photo created successfully"
    else
      flash[:alert] = "Failed to create photo"
    end

    redirect_to("/")
  end

  def edit
    @photo = Photo.find(params.fetch("id"))
    render({ template: "photos/edit" })
  end

  def update
    the_photo = Photo.find(params.fetch("id"))
    the_photo.caption = params.fetch("caption")
    the_photo.image = params.fetch("image")

    if the_photo.save
      flash[:notice] = "Photo updated successfully"
    else
      flash[:alert] = "Failed to update photo"
    end

    redirect_to("/photos/#{the_photo.id}")
  end

  def destroy
    the_photo = Photo.find(params.fetch("id"))
    the_photo.destroy

    flash[:alert] = "Photo deleted successfully"
    redirect_to("/")
  end

  private

  def ensure_signed_in
    unless user_signed_in?
      redirect_to("/users/sign_in")
    end
  end
end
