class UsersController < ApplicationController
  # Make index public
  skip_before_action :ensure_signed_in, only: [:index]
  before_action :ensure_signed_in, except: [:index]

  def index
    @users = User.all
    render({ :template => "users/index" })
  end

  def show
    matching_users = User.where({ :username => params.fetch("username") })
    @user = matching_users.at(0)

    @photos = Photo.where({ :owner_id => @user.id })
    render({ :template => "users/show" })
  end

  def feed
    matching_users = User.where({ :username => params.fetch("username") })
    @user = matching_users.at(0)

    following_ids = FollowRequest.where({
      :sender_id => @user.id,
      :status    => "accepted"
    }).pluck(:recipient_id)

    @photos = Photo.where({ :owner_id => following_ids })
                   .order({ :created_at => :desc })
    render({ :template => "users/feed" })
  end

  def liked_photos
    matching_users = User.where({ :username => params.fetch("username") })
    @user = matching_users.at(0)

    liked_ids = Like.where({ :fan_id => @user.id }).pluck(:photo_id)

    @photos = Photo.where({ :id => liked_ids })
                   .order({ :created_at => :desc })
    render({ :template => "users/liked_photos" })
  end

  def discover
    matching_users = User.where({ :username => params.fetch("username") })
    @user = matching_users.at(0)

    following_ids = FollowRequest.where({
      :sender_id => @user.id,
      :status    => "accepted"
    }).pluck(:recipient_id)

    liked_ids = Like.where({ :fan_id => following_ids }).pluck(:photo_id)

    @photos = Photo.where({ :id => liked_ids })
                   .order({ :created_at => :desc })
    render({ :template => "users/discover" })
  end

  private

  def ensure_signed_in
    unless user_signed_in?
      redirect_to("/users/sign_in")
    end
  end
end
