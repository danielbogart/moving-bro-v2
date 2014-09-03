class AddTokenToUserGroups < ActiveRecord::Migration
  def change
    add_column :user_groups, :token, :string
    add_index :user_groups, :token, unique: true
  end
end
