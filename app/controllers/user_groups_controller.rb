class UserGroupsController < ApplicationController

	def index
	end

	def create
		@group = current_user.user_groups.create(group_params)
	end

	def item_params
		params.require(:user_group).permit(:group_name)
	end

end
