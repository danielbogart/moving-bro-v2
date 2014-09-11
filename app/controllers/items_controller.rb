class ItemsController < ApplicationController

	def index
  		@item = Item.new
  		@items = Item.all
  		if current_user.admin? == false
  			redirect_to '/', :error => "That page is superuser only"
  		end  
	end

	def create
		@item = Item.create(item_params)
		redirect_to '/items', :notice => "Your item has created"
	end

	def item_params
		params.require(:item).permit(:item_name, :category_name, :amazon_affiliate_link)
	end

end
