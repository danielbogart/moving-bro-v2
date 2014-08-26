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

	def update
		current_user.update(:user_group => UserGroup.find_by_group_name(params[:id]))
		redirect_to '/user_groups', :notice => "You have joined #{UserGroup.find_by_group_name(params[:id]).group_name}"
	end

	def group_params
		params.require(:user_group).permit(:group_name)
	end

	def show
		@user_group = UserGroup.find_by_group_name(params[:id])
    end

    def update_user_group_items
    	#Update UGI list 
    	UserGroupItem.where(:id => params[:user_group_item_ids]).update_all(:taken => 0)
    	redirect_to user_group_path(current_user.user_group.group_name), :notice => "Your items have been updated"
    end

    #use a method that isn't named destroy? leave_user_group?
    def destroy
    	current_user.update(:user_group => nil)
		redirect_to '/user_groups', :notice => "You have left #{UserGroup.find_by_group_name(params[:id]).group_name}"
    end

    def taken_items
    	@user_group = current_user.user_group
    end

    def update_taken_items
    	UserGroupItem.where(:id => params[:user_group_item_ids]).update_all(:taken => 1)
    	redirect_to user_group_path(current_user.user_group.group_name), :notice => "Your items have been updated"
    end

end
