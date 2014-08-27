class UserGroup < ActiveRecord::Base

	has_many :user_group_items
	has_many :users #added - not in original gist
	has_many :items, through: :user_group_items

  has_secure_password
  validates :password_digest, :length => { :minimum => 4 }, :presence => true

	validates :group_name, :presence => true, :uniqueness => true

	def create_group_items
		Item.all.each do |item|
			user_group_item = self.user_group_items.build(item_id: item.id, taken: 1)
			user_group_item.save
		end
	end

  #instance method below (may need .references(:user_group_items) at the end)
  def not_taken_items
    self.items.includes(:user_group_items).where('user_group_items.taken > 0')
  end

  def taken_items
    self.items.includes(:user_group_items).where('user_group_items.taken = 0')
  end

  def not_taken_user_group_items
    self.user_group_items.where('taken > 0').order("created_at DESC")
  end

  def taken_user_group_items
    self.user_group_items.where('taken = 0').order("created_at DESC")
  end

  #can start with where since class is already called
  #? is a placeholder for whatever needs to be passed in to sql
  #example of a class method, runs on the class itself
  def self.one_week_old
    where('created_at < ?', 1.week.ago)
  end

	after_create :create_group_items
  	
end
