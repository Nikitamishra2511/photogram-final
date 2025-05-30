# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  comments_count         :integer
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  likes_count            :integer
#  private                :boolean
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  username               :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  devise(:database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable)

  def comments
    matching_comments = Comment.where({ :author_id => self.id })
    return matching_comments
  end

  def likes
    matching_likes = Like.where({ :fan_id => self.id })
    return matching_likes
  end

  def photos
    matching_photos = Photo.where({ :owner_id => self.id })
    return matching_photos
  end
end
