class GoalsController < ApplicationController
	before_filter :get_user
	def get_user
		@user = User.find(params[:user_id])
	end
	
	def index
    @complete_goals = @user.goals.where(complete: true)
	@incomplete_goals = @user.goals.where(complete: false)

    respond_to do |format|
      format.html # index.html.erb
      
    end
  end
  def show
    @goal = @user.goals.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @goal }
    end
  end
  def new
    @goal = current_user.goals.build
  end

  # GET /goals/1/edit
  def edit
    @goal = @user.goals.find(params[:id])
  end

  # POST /goals
  # POST /goals.json
  def create
    @goal = current_user.goals.build(params[:goal])
	if @goal.save
		@goal.create_activity :create, owner: current_user
		flash[:success] = "Rutina creada!"
		respond_to do |format|
			format.html {redirect_to user_goals_url(@user)}
			format.js
		end
	else
		redirect_to @user
	end
  end

  # PUT /goals/1
  # PUT /goals/1.json
  def update
    @goal = @user.goals.find(params[:id])
	@goal.update_attributes!(params[:goal])
	@goal.create_activity :update, owner: current_user
    respond_to do |format|
		format.html {redirect_to user_goals_url(@user)}
		format.js
	end
    
    
  end

  # DELETE /goals/1
  # DELETE /goals/1.json
  def destroy
    @goal = @user.goals.find(params[:id])
    @goal.destroy

    respond_to do |format|
      format.html { redirect_to user_goals_url(@user) }
      format.json { head :no_content }
	  format.js
    end
  end
end
