class RoutinesController < ApplicationController
  before_filter :signed_in_user

  def create
	@routine = current_user.routines.build(params[:routine])
	if @routine.save
		@routine.create_activity :create, owner: current_user
		flash[:success] = "Rutina creada!"
		redirect_to current_user
	else
		render 'new'
	end
  end
  
  def new
	@routine = current_user.routines.build
	
		routine_days = @routine.routine_days.build
		2.times {routine_days.excercises.build}
	
	
  end
  def show
	@routine = Routine.find(params[:id])
  end

  def destroy
  end
end