class Photo < ApplicationRecord
  belongs_to :owner, class_name: "User"
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  # This assumes you're using image as a string (not Active Storage)
  # Do NOT use `.attached?` checks
end

