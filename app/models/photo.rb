# == Schema Information
#
# Table name: photos
#
#  id             :bigint           not null, primary key
#  caption        :text
#  comments_count :integer
#  image          :string
#  likes_count    :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  owner_id       :integer
#
class Photo < ApplicationRecord
  mount_uploader(:image, ImageUploader)

  def user
    matching_users = User.where({ :id => self.owner_id })
    return matching_users.at(0)
  end

  def comments
    matching_comments = Comment.where({ :photo_id => self.id })
    return matching_comments
  end

  def likes
    matching_likes = Like.where({ :photo_id => self.id })
    return matching_likes
  end
end
