# == Schema Information
#
# Table name: comments
#
#  id         :bigint           not null, primary key
#  body       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  fan_id     :integer
#  photo_id   :integer
#
class Comment < ApplicationRecord
   def fan
     matching_users = User.where({ :id => self.fan_id })
     matching_users.at(0)
   end

   def photo
     matching_photos = Photo.where({ :id => self.photo_id })
     matching_photos.at(0)
   end
 end
