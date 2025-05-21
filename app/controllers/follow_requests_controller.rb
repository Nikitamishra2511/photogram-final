class FollowRequestsController < ApplicationController
  def create
    @follow_request = FollowRequest.new
    @follow_request.sender = current_user
    @follow_request.recipient_id = params.fetch(:recipient_id)

    recipient = User.find(@follow_request.recipient_id)

    if recipient.private?
      @follow_request.status = "pending"
      message = "Follow request sent!"
    else
      @follow_request.status = "accepted"
      message = "You are now following #{recipient.username}."
    end

    if @follow_request.save
      redirect_to user_profile_path(recipient.username), notice: message
    else
      redirect_to users_path, alert: "Unable to send follow request."
    end
  end

  def update
    @follow_request = FollowRequest.find(params.fetch(:id))

    new_status = params.fetch(:status)

    if @follow_request.recipient == current_user && %w[accepted rejected].include?(new_status)
      @follow_request.update(status: new_status)
      redirect_to user_profile_path(current_user.username), notice: "Request #{new_status}."
    else
      redirect_to user_profile_path(current_user.username), alert: "Unauthorized action."
    end
  end

  def destroy
    @follow_request = FollowRequest.find(params.fetch(:id))

    if @follow_request.sender == current_user || @follow_request.recipient == current_user
      @follow_request.destroy
      redirect_back fallback_location: users_path, notice: "Follow request removed."
    else
      redirect_back fallback_location: users_path, alert: "Unauthorized action."
    end
  end
end

