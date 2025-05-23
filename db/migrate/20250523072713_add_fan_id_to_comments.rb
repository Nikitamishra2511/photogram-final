class AddFanIdToComments < ActiveRecord::Migration[7.1]
  def change
    add_column :comments, :fan_id, :integer
  end
end
