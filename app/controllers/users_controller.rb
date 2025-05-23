class UsersController < ApplicationController
  # anyone can see the list of users
  skip_before_action(:authenticate_user!, { :only => [:index] })

  def index
    @list_of_users = User.all
    render({ :template => "users/index" })
  end

  def show
    the_username    = params.fetch("username")
    matching_users  = User.where({ :username => the_username })
    @the_user       = matching_users.at(0)
    render({ :template => "users/show" })
  end

  def feed
    current_user = User.where({ :id => session.fetch("user_id") }).at(0)

    # everyone I’m following (accepted)
    accepted_requests = FollowRequest.where({ :follower_id => current_user.id,
                                              :status      => "accepted" })
    followee_ids      = accepted_requests.map { |req| req.followee_id }

    @list_of_photos = Photo.where({ :owner_id => followee_ids })
    render({ :template => "users/feed" })
  end

  def liked_photos
    current_user = User.where({ :id => session.fetch("user_id") }).at(0)

    # photos I’ve liked
    my_likes    = Like.where({ :fan_id => current_user.id })
    photo_ids   = my_likes.map { |like| like.photo_id }

    @liked_photos = Photo.where({ :id => photo_ids })
    render({ :template => "users/liked_photos" })
  end

  def discover
    current_user = User.where({ :id => session.fetch("user_id") }).at(0)

    # photos liked by people I follow
    accepted_requests = FollowRequest.where({ :follower_id => current_user.id,
                                              :status      => "accepted" })
    followee_ids      = accepted_requests.map { |req| req.followee_id }

    their_likes   = Like.where({ :fan_id => followee_ids })
    liked_ids     = their_likes.map { |like| like.photo_id }.uniq

    @discovered_photos = Photo.where({ :id => liked_ids })
    render({ :template => "users/discover" })
  end

  # You’ll rely on FollowRequestsController#create/destroy for actual follow/unfollow.
  # The UsersController only displays the right buttons/links.
end
