class UserGroupItem < ActiveRecord::Base

	belongs_to :user_group
  	belongs_to :item

  	#works but places blank rows in table on view
    def cleaning_item
      if self.item.category_name == "Cleaning"
      	return self.item.item_name
      else
      end
   	end

end
