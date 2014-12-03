class Goal < ActiveRecord::Base
  include PublicActivity::Common
  attr_accessible :complete, :name, :user_id
  belongs_to :user
  
   validates :name, presence: true, length: { maximum: 100 }
end
