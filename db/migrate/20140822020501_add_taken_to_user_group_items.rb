class AddTakenToUserGroupItems < ActiveRecord::Migration
  def change
  	add_column :user_group_items, :taken, :integer
  end
end
