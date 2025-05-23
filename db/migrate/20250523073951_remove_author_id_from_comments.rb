class RemoveAuthorIdFromComments < ActiveRecord::Migration[7.1]
  def change
    remove_column(:comments, :author_id, :integer)
  end
end
