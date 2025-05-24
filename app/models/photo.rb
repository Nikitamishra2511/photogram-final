
class Photo < ApplicationRecord
     mount_uploader(:image, ImageUploader)

  def comments
    Comment.where({ :photo_id => self.id })
  end

  def likes
    Like.where({ :photo_id => self.id })
  end

  def user
    User.where({ :id => self.owner_id }).at(0)
  end
end
