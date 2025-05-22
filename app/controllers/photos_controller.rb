class PhotosController < ApplicationController
  def index
    @photos = Photo.all
  end

  def show
    @photo = Photo.find(params[:id])
  end

  def new
    @photo = Photo.new
  end

  def create
    @photo = Photo.new(photo_params)
    @photo.owner_id = current_user.id

    if @photo.save
      redirect_to photo_path(@photo), notice: "Photo created successfully."
    else
      render :new
    end
  end

  def edit
    @photo = Photo.find(params[:id])
  end

  def update
    @photo = Photo.find(params[:id])

    if @photo.update(photo_params)
      redirect_to photo_path(@photo), notice: "Photo updated successfully."
    else
      render :edit
    end
  end

  def destroy
    @photo = Photo.find(params[:id])
    @photo.destroy
    redirect_to photos_path, alert: "Photo deleted successfully."
  end

  private

  def photo_params
    params.require(:photo).permit(:image, :caption)
  end
end
