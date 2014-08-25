class UserGroupsController < ApplicationController

	def index
		@groups = UserGroup.all
		@group = UserGroup.new
		@my_group = current_user.user_group
	end

	def create
		@group = current_user.create_user_group(group_params)
		current_user.user_group = @group
		current_user.save
		redirect_to '/user_groups', :notice => "Your group has created"
	end

	def group_params
		params.require(:user_group).permit(:group_name)
	end

	def show
		@group_page = params[:id]

    	#this line should show only UGI where taken = 1 (or more in the future)
    	@user_group_items = UserGroup.where(["group_name = ?", @group_page]).first.user_group_items

    end

    def update_user_group_items
    	#Update UGI list 
    	UserGroupItem.where(:id => params[:user_group_item_ids]).update_all(:taken => 0)
    	redirect_to user_group_path(current_user.user_group.group_name), :notice => "Your items have been updated"
    end
end
