class Measurement < ActiveRecord::Base

  include PublicActivity::Common
  attr_accessible :back, :height, :leftArm, :leftLeg, :rightArm, :rightLeg, :waits, :weight
 
  belongs_to :user
  
  validates_numericality_of :back, :only_integer =>true, :greater_than_or_equal_to =>0, :message => "invalid fundays"
end
