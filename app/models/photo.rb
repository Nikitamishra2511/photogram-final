class Photo < ApplicationRecord
  belongs_to :owner, class_name: "User", foreign_key: "owner_id"
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  mount_uploader :image, PhotoUploader

  validates :caption, presence: true
  validates :image, presence: true, if: :validate_image_required?

  # used by specs to check <img src>
  def image_identifier
    return self.image.url
  end

  # view‐logic helper for URL presence
  def valid_image_url?
    return self.image.present? && self.image.url.present?
  end

  private

  def validate_image_required?
    return true
  end
end
