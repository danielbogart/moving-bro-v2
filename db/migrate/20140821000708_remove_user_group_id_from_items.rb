class RemoveUserGroupIdFromItems < ActiveRecord::Migration
  def change
    remove_column :items, :user_group_id, :integer
  end
end
