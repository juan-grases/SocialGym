class SingleExcercisesController < ApplicationController

	def index
	  @single_excercises = SingleExcercise.order(:name).where("name like ?", "%#{params[:term]}%")
	  render json: @single_excercises.map(&:name)
	end
end
