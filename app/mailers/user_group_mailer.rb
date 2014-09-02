class UserGroupMailer < ActionMailer::Base
  default from: "movingbroemail@gmail.com"

  def join_group_confirmation(group_id, user_id)
  	@group = UserGroup.find(group_id)
  	mail to: User.find(user_id).email, subject: "Thanks for joining!"
  end

end
