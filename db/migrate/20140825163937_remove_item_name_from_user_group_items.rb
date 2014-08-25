class RemoveItemNameFromUserGroupItems < ActiveRecord::Migration
  def change
  	remove_column :user_group_items, :item_name, :integer
  end
end
