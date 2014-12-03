# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation, :admin
  has_secure_password
  
  has_many :routines, dependent: :destroy
  has_many :goals, dependent: :destroy
  has_many :measurements, dependent: :destroy
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  
  has_many :reverse_relationships, foreign_key: "followed_id",
                                   class_name:  "Relationship",
                                   dependent:   :destroy
  has_many :followers, through: :reverse_relationships, source: :follower
  
  before_save { |user| user.email = email.downcase }
  before_create { generate_token(:remember_token) }
  
   validates :name, presence: true, length: { maximum: 50 }
   VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
   validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
				  uniqueness: { case_sensitive: false }
				  
	validates :password, presence: true, length: { minimum: 6 }
	validates :password_confirmation, presence: true
	
	def self.search(search)
	  if search
		find(:all, :conditions => ['name LIKE ?', "%#{search}%"])
	  else
		find(:all)
	  end
	end
	
	def following?(other_user)
    relationships.find_by_followed_id(other_user.id)
	end

	def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
	end
	def unfollow!(other_user)
    relationships.find_by_followed_id(other_user.id).destroy
	end
	
	def send_password_reset
	  generate_token(:password_reset_token)
	  self.password_reset_sent_at = Time.zone.now
	  save!(validate: false)
	  UserMailer.password_reset(self).deliver
	end
	
	private

    def generate_token(column)
	  begin
		self[column] = SecureRandom.urlsafe_base64
	  end while User.exists?(column => self[column])
    end
	
	

end