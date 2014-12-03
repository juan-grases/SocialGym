class Routine_daysController < ApplicationController
  before_filter :signed_in_user

  def create
	@routine_day = @routine.build(params[:micropost])
	@rutine_day.save
	
  end
  
  def destroy
  
  end
end