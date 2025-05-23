class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def photos
    Photo.where({ :user_id => self.id })
  end

  def comments
    Comment.where({ :author_id => self.id })
  end

  def likes
    Like.where({ :fan_id => self.id })
  end

  def sent_follow_requests
    FollowRequest.where({ :sender_id => self.id })
  end

  def received_follow_requests
    FollowRequest.where({ :recipient_id => self.id })
  end
end
