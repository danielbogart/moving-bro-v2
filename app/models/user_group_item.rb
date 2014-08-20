class UserGroupItem < ActiveRecord::Base

	belongs_to :user_group
  	belongs_to :item

end
