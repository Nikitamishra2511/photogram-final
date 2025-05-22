class User < ApplicationRecord
  # Devise modules
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Associations
  has_many :photos, foreign_key: "owner_id", dependent: :destroy
  has_many :comments, foreign_key: "author_id", dependent: :destroy
  has_many :likes, foreign_key: "fan_id", dependent: :destroy

  has_many :sent_follow_requests, class_name: "FollowRequest", foreign_key: "sender_id", dependent: :destroy
  has_many :received_follow_requests, class_name: "FollowRequest", foreign_key: "recipient_id", dependent: :destroy

  # Followers and Following
  has_many :accepted_sent_follow_requests, -> { where(status: "accepted") }, 
           class_name: "FollowRequest", foreign_key: "sender_id"

  has_many :accepted_followings, through: :accepted_sent_follow_requests, source: :recipient

  has_many :accepted_received_follow_requests, -> { where(status: "accepted") }, 
           class_name: "FollowRequest", foreign_key: "recipient_id"

  has_many :accepted_followers, through: :accepted_received_follow_requests, source: :sender
end
