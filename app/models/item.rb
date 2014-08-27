class Item < ActiveRecord::Base

	has_many :user_group_items
	has_many :user_groups, through: :user_group_items

end
