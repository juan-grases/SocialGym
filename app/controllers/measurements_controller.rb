class MeasurementsController < ApplicationController
  # GET /measurements
  # GET /measurements.json
  before_filter :get_user
  def get_user
	@user = User.find(params[:user_id])
  end
  def index
    @measurements = @user.measurements

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @measurements }
    end
  end

  # GET /measurements/1
  # GET /measurements/1.json
  def show
    @measurement = @user.measurements.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @measurement }
    end
  end

  # GET /measurements/new
  # GET /measurements/new.json
  def new
    @measurement = current_user.measurements.build
  end

  # GET /measurements/1/edit
  def edit
    @measurement = @user.measurements.find(params[:id])
  end

  # POST /measurements
  # POST /measurements.json
  def create
    @measurement = current_user.measurements.build(params[:measurement])
	
	if @measurement.save
		@measurement.create_activity :create, owner: current_user
		respond_to do |format|
			format.html {redirect_to user_measurements_url(@user)}
			format.js
		end
	else
		redirect_to @user
	end
  end

  # PUT /measurements/1
  # PUT /measurements/1.json
  def update
    @measurement = @user.measurements.find(params[:id])

    respond_to do |format|
      if @measurement.update_attributes(params[:measurement])
        format.html { redirect_to @measurement, notice: 'Measurement was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @measurement.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /measurements/1
  # DELETE /measurements/1.json
  def destroy
    @measurement = @user.measurements.find(params[:id])
    @measurement.destroy

    respond_to do |format|
      format.html { redirect_to measurements_url }
	  format.js
    end
  end
end
