class PhotosController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @photos = Photo.all.order(created_at: :desc)
  end

  def show
    @photo = Photo.find(params.fetch(:id))
    @owner = @photo.owner
    @comments = @photo.comments.order(created_at: :asc)

    if user_signed_in?
      @like = Like.find_by(photo_id: @photo.id, fan_id: current_user.id)
      @new_comment = Comment.new
      @new_like = Like.new
    end
  end

  def new
    @photo = Photo.new
  end

  def create
    @photo = Photo.new(photo_params)
    @photo.owner = current_user

    if @photo.save
      redirect_to photo_path(@photo), notice: "Photo created successfully."
    else
      render :new
    end
  end

  def edit
    @photo = Photo.find(params.fetch(:id))

    unless @photo.owner == current_user
      redirect_to photo_path(@photo), alert: "You are not authorized to edit this photo."
    end
  end

  def update
    @photo = Photo.find(params.fetch(:id))

    if @photo.owner != current_user
      redirect_to photo_path(@photo), alert: "You are not authorized to update this photo."
    elsif @photo.update(photo_params)
      redirect_to photo_path(@photo), notice: "Photo updated successfully."
    else
      render :edit
    end
  end

  def destroy
    @photo = Photo.find(params.fetch(:id))

    if @photo.owner == current_user
      @photo.destroy
      redirect_to photos_path, notice: "Photo deleted successfully."
    else
      redirect_to photo_path(@photo), alert: "You are not authorized to delete this photo."
    end
  end

  private

  def photo_params
    params.require(:photo).permit(:caption, :image)
  end
end
