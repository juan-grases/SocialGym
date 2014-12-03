class Excercise < ActiveRecord::Base
  attr_accessible :name, :reps, :routine_day_id, :series, :excercise_name
  belongs_to :routine_day
  belongs_to :single_excercise
  def excercise_name
    self.single_excercise.try(:name)
  end
  
  def excercise_name=(name)
    self.single_excercise = SingleExcercise.find_or_create_by_name(name) if name.present?
  end
  
	
	
end
