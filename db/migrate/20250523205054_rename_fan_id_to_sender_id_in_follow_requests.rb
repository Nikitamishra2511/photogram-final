 class RenameFanIdToSenderIdInFollowRequests < ActiveRecord::Migration[7.1]
   def change
     rename_column :follow_requests, :fan_id, :sender_id
   end
 end
