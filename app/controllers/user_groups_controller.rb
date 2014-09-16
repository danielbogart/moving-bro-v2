class UserGroupsController < ApplicationController

	before_action :authenticate_user!
	
	def index
		@groups = UserGroup.all
		@group = UserGroup.new
		@my_group = current_user.user_group
        if current_user.user_group != nil 
            encoded_url = URI.encode('/user_groups/'+current_user.user_group.group_name) 
            URI.parse(encoded_url)           
            redirect_to encoded_url
        end
	end

	def create
		@group = current_user.create_user_group(group_params)
        if @group.valid?
    		current_user.user_group = @group
    		current_user.save		
			redirect_to '/user_groups/'+@group.group_name.gsub(/\s/,'%20'), :notice => "Your group has been created"
		else
			redirect_to '/user_groups/', :error => "Error: group name may already be taken. Search, or try a new name."
		end
	end

	def update
		group_name = params[:id] || params[:user_group][:group_name]
		@user_group = UserGroup.find_by_group_name(group_name)
		if @user_group && @user_group.authenticate(params[:user_group][:password])
			current_user.update(:user_group => @user_group)
			#UserGroupMailer.join_group_confirmation(@user_group.id, current_user.id).deliver
			redirect_to user_group_path(current_user.user_group.group_name), :notice => "You have joined #{@user_group.group_name}"
		else
			redirect_to '/user_groups', :error => "Error, couldn't join #{group_name}. Invalid group name or password"
		end
	end

	def group_params
		params.require(:user_group).permit(:group_name, :password)
	end

	def show
		@user_group = UserGroup.find_by_group_name(params[:id])
        i = 1
        links = []
        links2 = []
        @user_group.not_taken_user_group_items.each do |p| 
            if i <= 46 
                links.push("&ASIN." + i.to_s + "=" + p.item.amazon_affiliate_link + "&Quantity." + i.to_s + "=1")
                i+= 1
            else
                links2.push("&ASIN." + (i-46).to_s + "=" + p.item.amazon_affiliate_link + "&Quantity." + (i-46).to_s + "=1")
                i+= 1
            end
        end
        @amazon_link = "http://www.amazon.com/gp/aws/cart/add.html?AssociateTag=movbro-20"+links.map { |x| x.to_s }.join("")
        @amazon_link2 = "http://www.amazon.com/gp/aws/cart/add.html?AssociateTag=movbro-20"+links2.map { |x| x.to_s }.join("")
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

    def search
    	@user_group_results = UserGroup.search(params[:search])
        @paginated_results = UserGroup.search(params[:search]).paginate(:page => params[:page], )
    end

    #added for JS popup
    def join_user_group
    	@group = UserGroup.new
    	@group_name = params[:group_name]
       	@group_id = UserGroup.find_by_group_name(@group_name).id
    end

    #email link brings new users here
    def join_by_email
    	@user_group = UserGroup.find_by_token(params[:token])
		current_user.update(:user_group => @user_group)
		UserGroupMailer.join_group_confirmation(@user_group.id, current_user.id).deliver
		redirect_to '/user_groups', :notice => "You have joined #{@user_group.group_name}"
    end

    #for form to invite new members by email
    def invite_members
    end

    #when form is posted, following method executed
    def send_invite_to_members
    	token = current_user.user_group.token
    	emails = params[:user_emails][:emails].split(",")
        begin
          emails.each do |e|
            #UserGroupMailer.delay.group_invitation_email(e, token) - with redis
            UserGroupMailer.group_invitation_email(e, token).deliver 
          end
          encoded_url = URI.encode('/user_groups/'+current_user.user_group.group_name) 
          URI.parse(encoded_url)           
    	  redirect_to encoded_url, :notice => "Your invitations have been sent"
        rescue Net::SMTPAuthenticationError, Net::SMTPServerBusy, Net::SMTPSyntaxError, Net::SMTPFatalError, Net::SMTPUnknownError => e
        redirect_to '/user_groups/'+token+'/invite_members', :error => "Error sending emails. Check format and try again"
        end
    end

end
