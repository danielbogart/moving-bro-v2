class UserGroupsController < ApplicationController

	def index
		@groups = UserGroup.all
		@group = UserGroup.new
		@my_groups = current_user.user_groups.all
	end

	def create
		@group = current_user.user_groups.create(group_params)
		redirect_to '/user_groups', :notice => "Your group has created"
	end

	def group_params
		params.require(:user_group).permit(:group_name)
	end

	def show
		@group_page = params[:id]
    	@user_group_items = Item.where(user_group_id: UserGroup.where(["group_name = ?", @group_page]).first.id)  
    end
end
