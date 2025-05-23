# == Schema Information
#
# Table name: comments
#
#  id         :bigint           not null, primary key
#  body       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  author_id  :integer
#  photo_id   :integer
#
class Comment < ApplicationRecord
  def author
    matching_users = User.where({ :id => self.author_id })
    return matching_users.at(0)
  end

  def photo
    matching_photos = Photo.where({ :id => self.photo_id })
    return matching_photos.at(0)
  end
end
