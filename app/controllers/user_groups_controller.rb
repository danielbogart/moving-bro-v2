class UserGroupsController < ApplicationController

	def index
		@groups = UserGroup.all
		@group = UserGroup.new
	end

	def create
		@group = UserGroup.create(group_params)
		redirect_to '/user_groups', :notice => "Your group has created"
	end

	def group_params
		params.require(:user_group).permit(:group_name)
	end

end
