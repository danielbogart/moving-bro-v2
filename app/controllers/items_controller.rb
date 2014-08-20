class ItemsController < ApplicationController

	def index
  		@item = Item.new
  		@items = Item.all
	end

	def create
		@item = Item.create(item_params) #fix to be associated with users "current" group, not just first
		redirect_to '/items', :notice => "Your item has created"
	end

	def item_params
		params.require(:item).permit(:item_name, :user_group_id)
	end

end
