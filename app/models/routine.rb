class Routine < ActiveRecord::Base
  include PublicActivity::Common
  attr_accessible :description, :name, :user_id, :routine_days_attributes, :private
  belongs_to :user
  has_many :routine_days
  
  accepts_nested_attributes_for :routine_days, :reject_if => lambda { |a| a[:cardio_information].blank? }, :allow_destroy => true
  
  validates :user_id, presence: true
  validates :description, presence: true, length: { maximum: 200 }
  validates :name, presence: true, length: { maximum: 50 }
  
  default_scope order: 'routines.created_at DESC'
end
