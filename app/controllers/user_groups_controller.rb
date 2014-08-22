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
    	@user_group_items = UserGroup.where(["group_name = ?", @group_page]).first.items
    end
end
