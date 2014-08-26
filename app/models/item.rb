class Item < ActiveRecord::Base

	has_many :user_group_items
	has_many :user_groups, through: :user_group_items


  #get this working to use instead of if/else statements in view
  def cleaning_items
      self.where('category_name = ?', 'Cleaning')
  end

end
