class CreateFollowRequests < ActiveRecord::Migration[7.1]
  def change
    create_table :follow_requests do |t|
      t.integer :fan_id
      t.integer :recipient_id
      t.string :status

      t.timestamps
    end
  end
end
