class RoutineDay < ActiveRecord::Base
  attr_accessible :cardio_information, :description, :routine_id, :excercises_attributes
  has_many :excercises
  belongs_to :routine
  accepts_nested_attributes_for :excercises, :reject_if=> proc {|attributes| attributes[:reps].blank?},  :allow_destroy => true
  
  
end
