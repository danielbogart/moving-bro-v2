class CreateUserGroupItems < ActiveRecord::Migration
  def change
    create_table :user_group_items do |t|
      t.integer :user_group_id
      t.integer :item_id

      t.timestamps
    end
  end
end
