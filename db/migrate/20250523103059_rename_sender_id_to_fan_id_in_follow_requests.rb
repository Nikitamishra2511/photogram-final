class RenameSenderIdToFanIdInFollowRequests < ActiveRecord::Migration[7.1]
  def change
    rename_column(:follow_requests, :sender_id, :fan_id)
  end
end
