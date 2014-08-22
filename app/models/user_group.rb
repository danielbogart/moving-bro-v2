class UserGroup < ActiveRecord::Base

	has_many :user_group_items
	has_many :users #added - not in original gist
  	has_many :items, through: :user_group_items
  	
  	validates :group_name, :presence => true, :uniqueness => true

  	def create_group_items
  		Item.all.each do |item|
  			user_group_item = self.user_group_items.build(item_id: item.id, taken: 1)
  			user_group_item.save
  		end
  	end

  	after_create :create_group_items
  	
end
