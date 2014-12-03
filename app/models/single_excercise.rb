class SingleExcercise < ActiveRecord::Base
  attr_accessible :name
  has_many :excercises
end
