class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @users = User.all.order(:username)
  end

  def show
    @user = User.find_by(username: params.fetch(:username))
    @photos = @user.photos.order(created_at: :desc)

    # For follow request button status
    if user_signed_in?
      @follow_request = FollowRequest.find_by(sender: current_user, recipient: @user)
    end

    # If viewing own private profile, show pending follow requests
    if current_user == @user && @user.private?
      @pending_requests = @user.received_follow_requests.where(status: "pending")
    end
  end

  def feed
    @user = User.find_by(username: params.fetch(:username))

    followees = @user.sent_follow_requests
                     .where(status: "accepted")
                     .includes(:recipient)
                     .map(&:recipient)

    @feed_photos = Photo.where(owner_id: followees.map(&:id)).order(created_at: :desc)
  end

  def liked_photos
    @user = User.find_by(username: params.fetch(:username))
    @liked_photos = @user.likes.includes(:photo).map(&:photo).uniq
  end

  def discover
    @user = User.find_by(username: params.fetch(:username))

    followees = @user.sent_follow_requests
                     .where(status: "accepted")
                     .includes(:recipient)
                     .map(&:recipient)

    liked_by_followees = Like.where(fan_id: followees.map(&:id))
    @discover_photos = Photo.where(id: liked_by_followees.map(&:photo_id)).distinct
  end
end
