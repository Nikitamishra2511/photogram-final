# == Schema Information
#
# Table name: follow_requests
#
#  id           :bigint           not null, primary key
#  status       :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  fan_id       :integer
#  recipient_id :integer
#
class FollowRequest < ApplicationRecord
end
