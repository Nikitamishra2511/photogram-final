class FollowRequestsController < ApplicationController
  def index
    @list_of_requests = FollowRequest.all
    render({ :template => "follow_requests/index" })
  end

  def new
    render({ :template => "follow_requests/new" })
  end

  def create
    the_request             = FollowRequest.new
    the_request.sender_id    = current_user.id
    the_request.recipient_id = params.fetch("recipient_id")

    recipient = User.where({ :id => the_request.recipient_id }).at(0)
    if recipient.private
      the_request.status = "pending"
    else
      the_request.status = "accepted"
    end

    the_request.save
    redirect_to("/follow_requests")
  end

  def show
    the_id           = params.fetch("an_id")
    @the_request     = FollowRequest.where({ :id => the_id }).at(0)
    render({ :template => "follow_requests/show" })
  end

  def edit
    the_id           = params.fetch("an_id")
    @the_request     = FollowRequest.where({ :id => the_id }).at(0)
    render({ :template => "follow_requests/edit" })
  end

  def update
    the_id           = params.fetch("an_id")
    the_request      = FollowRequest.where({ :id => the_id }).at(0)
    the_request.status = params.fetch("status")
    the_request.save

    redirect_to("/follow_requests/" + the_id)
  end

  def destroy
    the_id           = params.fetch("an_id")
    the_request      = FollowRequest.where({ :id => the_id }).at(0)
    the_request.destroy

    redirect_to("/follow_requests")
  end
end