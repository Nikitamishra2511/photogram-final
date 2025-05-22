class PhotosController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @photos = Photo.includes(:owner).where(owner: { private: false })
    @new_photo = Photo.new
  end

  def show
    @photo = Photo.find(params[:id])
    @comments = @photo.comments.includes(:fan)
    @like = current_user&.likes&.find_by(photo_id: @photo.id)
  end

  def new
    @photo = Photo.new
  end

  def create
    @photo = Photo.new(photo_params)
    @photo.owner = current_user
    @photo.likes_count = 0
    @photo.comments_count = 0

    if @photo.save
      redirect_to photos_path, notice: "Photo created successfully"
    else
      redirect_to photos_path, alert: "Photo failed to create"
    end
  end

  def edit
    @photo = Photo.find(params[:id])
    if @photo.owner != current_user
      redirect_to photos_path, alert: "You are not authorized for that"
    end
  end

  def update
    @photo = Photo.find(params[:id])

    if @photo.owner != current_user
      redirect_to photos_path, alert: "You are not authorized for that"
      return
    end

    if @photo.update(photo_params)
      redirect_to photo_path(@photo), notice: "Photo updated successfully"
    else
      redirect_to photo_path(@photo), alert: "Photo failed to update"
    end
  end

  def destroy
    @photo = Photo.find(params[:id])

    if @photo.owner == current_user
      @photo.destroy
      redirect_to photos_path, alert: "Photo deleted successfully"
    else
      redirect_to photos_path, alert: "You are not authorized for that"
    end
  end

  private

  def photo_params
    params.require(:photo).permit(:image, :caption)
  end
end
