class UserGroup < ActiveRecord::Base

	has_many :user_group_items
  	has_many :items, through: :user_group_items
  	
end
