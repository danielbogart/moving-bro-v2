class UserGroupMailer < ActionMailer::Base
  default from: "Moving Bro"

  def join_group_confirmation(group_id, user_id)
  	@group = UserGroup.find(group_id)
  	mail to: User.find(user_id).email, subject: "Thanks for joining!"
  end

  def group_invitation_email(email_address, token)
  	@token = token.to_s
  	mail to: email_address, subject: "You've been invited bro!"
  end

end
