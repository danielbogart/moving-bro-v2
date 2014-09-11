class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  belongs_to :user_group #added - not in original gist
  has_many :items, through: :user_groups

  validates :role, presence: true, :inclusion => { :in => ['admin_bro', 'regular_bro'] }

  def admin?
  	self.role == "admin_bro"
  end

end
