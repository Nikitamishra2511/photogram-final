class Like < ApplicationRecord
  def fan
    User.where({ :id => self.fan_id }).at(0)
  end

  def photo
    Photo.where({ :id => self.photo_id }).at(0)
  end
end
