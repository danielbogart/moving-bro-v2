class AddUserGroupIdToItems < ActiveRecord::Migration
  def change
  	add_column :items, :user_group_id, :integer
  end
end
