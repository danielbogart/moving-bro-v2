class UserGroup < ActiveRecord::Base

	has_many :user_group_items
	has_many :users
	has_many :items, through: :user_group_items

  has_secure_password
  validates :password, :presence => true

	validates :group_name, :presence => true, :uniqueness => true
  validates :group_name, format: { with: /\A[a-zA-Z\s\d]+\z/,
    message: "Only letters and numbers allowed in group name" }

  before_validation :strip_blanks
  before_create { generate_token(:token) }
  after_create :create_group_items

  def strip_blanks
    self.group_name = self.group_name.strip
  end

  def self.per_page
    10
  end

	def create_group_items
		Item.all.each do |item|
			user_group_item = self.user_group_items.build(item_id: item.id, taken: 1)
			user_group_item.save
		end
	end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while UserGroup.exists?(column => self[column])
  end

  #instance method below (may need .references(:user_group_items) at the end)
  def not_taken_items
    self.items.includes(:user_group_items).where('user_group_items.taken > 0')
  end

  def taken_items
    self.items.includes(:user_group_items).where('user_group_items.taken = 0')
  end

  def not_taken_user_group_items
    self.user_group_items.where('taken > 0').order("created_at ASC")
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

  def self.search(search)
    if search
      self.where('lower(group_name) LIKE ?', "%#{search}%".downcase)
    else
      self.all
    end
  end
  	
end
