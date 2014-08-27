class AddPasswordDigestToUserGroup < ActiveRecord::Migration
  def change
  	add_column :user_groups, :password_digest, :string
  end
end
