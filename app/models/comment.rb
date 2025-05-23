class Comment < ApplicationRecord
  def author
    User.where({ :id => self.author_id }).at(0)
  end

  def photo
    Photo.where({ :id => self.photo_id }).at(0)
  end
end
