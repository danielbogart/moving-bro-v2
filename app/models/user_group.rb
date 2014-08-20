class UserGroup < ActiveRecord::Base

	has_many :user_group_items
	has_many :users #added - not in original gist
  	has_many :items, through: :user_group_items
  	
  	validates :group_name, :presence => true, :uniqueness => true
end
