class RemoveUserFromItems < ActiveRecord::Migration
  def change
    remove_column :items, :user, :string
  end
end
