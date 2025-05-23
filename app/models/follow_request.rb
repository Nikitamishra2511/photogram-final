class FollowRequest < ApplicationRecord
  def sender
    User.where({ :id => self.sender_id }).at(0)
  end

  def recipient
    User.where({ :id => self.recipient_id }).at(0)
  end
end 
