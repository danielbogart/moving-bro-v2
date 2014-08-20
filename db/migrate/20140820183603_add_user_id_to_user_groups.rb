class AddUserIdToUserGroups < ActiveRecord::Migration
  def change
  	add_column :user_groups, :user_id, :integer
  end
end
