class RemoveUserIdFromUserGroup < ActiveRecord::Migration
  def change
    remove_column :user_groups, :user_id, :integer
  end
end
