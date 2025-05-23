class Photo < ApplicationRecord
  def user
    User.where({ :id => self.user_id }).at(0)
  end

  def comments
    Comment.where({ :photo_id => self.id })
  end

  def likes
    Like.where({ :photo_id => self.id })
  end
end


