class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  add_flash_types :error

  def after_sign_in_path_for(resource)
  	if current_user.user_group == nil
    	'/user_groups'
    else
    	user_group_path(current_user.user_group.group_name)
    end
  end
end
