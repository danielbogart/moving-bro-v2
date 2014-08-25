class AddItemNameToUserGroupItems < ActiveRecord::Migration
  def change
    add_column :user_group_items, :item_name, :string
  end
end
