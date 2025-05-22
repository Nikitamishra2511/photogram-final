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
  belongs_to :owner, class_name: "User", foreign_key: "owner_id"
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
has_one_attached :image

  validates :caption, presence: true
  validates :image, presence: true, if: :validate_image_required?

  # ✅ Custom validator to ensure image is a valid HTTP(S) URL
  def valid_image_url?
    image.present? && image.match?(URI::DEFAULT_PARSER.make_regexp(%w[http https]))
  end

  private

  def validate_image_required?
    true # always require image in this assignment
  end
end
