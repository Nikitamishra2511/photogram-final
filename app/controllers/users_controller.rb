class UsersController < ApplicationController
  # Only the index page is public
  skip_before_action(:authenticate_user!, { :only => [:index] })

  def index
    matching_users = User.where({ })
    @list_of_users = matching_users
    render({ :template => "users/index" })
  end

  def show
    the_id         = params.fetch("an_id")
    matching_users = User.where({ :id => the_id })
    @the_user      = matching_users.at(0)
    render({ :template => "users/show" })
  end

def feed
  the_username = params.fetch("username")
  matching_users = User.where({ :username => the_username })
  @the_user = matching_users.at(0)

  accepted_requests = FollowRequest.where({
    :sender_id => @the_user.id,
    :status    => "accepted"
  })
  followee_ids    = accepted_requests.map { |fr| fr.recipient_id }
  @list_of_photos = Photo.where({ :owner_id => followee_ids })

  render({ :template => "users/feed" })
end

  def liked_photos
    the_id         = params.fetch("an_id")
    matching_users = User.where({ :id => the_id })
    @the_user      = matching_users.at(0)

    my_likes       = Like.where({ :fan_id => @the_user.id })
    photo_ids      = my_likes.map { |like| like.photo_id }
    @liked_photos  = Photo.where({ :id => photo_ids })

    render({ :template => "users/liked_photos" })
  end

  def discover
    the_id           = params.fetch("an_id")
    matching_users   = User.where({ :id => the_id })
    @the_user        = matching_users.at(0)

    accepted_requests = FollowRequest.where({
      :sender_id => @the_user.id,
      :status    => "accepted"
    })
    followee_ids      = accepted_requests.map { |fr| fr.recipient_id }
    their_likes       = Like.where({ :fan_id => followee_ids })
    liked_ids         = their_likes.map { |like| like.photo_id }.uniq
    @discovered_photos = Photo.where({ :id => liked_ids })

    render({ :template => "users/discover" })
  end

  def accept_follow_request
    the_id            = params.fetch("an_id")
    matching_requests = FollowRequest.where({ :id => the_id })
    the_request       = matching_requests.at(0)

    the_request.status = "accepted"
    the_request.save

    return redirect_to(
      "/users/#{ current_user.username }",
      { :notice => "Follow request accepted." }
    )
  end

  def reject_follow_request
    the_id            = params.fetch("an_id")
    matching_requests = FollowRequest.where({ :id => the_id })
    the_request       = matching_requests.at(0)

    the_request.status = "rejected"
    the_request.save

    return redirect_to(
      "/users/#{ current_user.username }",
      { :notice => "Follow request rejected." }
    )
  end
end
