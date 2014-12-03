class UsersController < ApplicationController
	before_filter :signed_in_user, only: [:index, :edit, :update, :destroy, :following, :followers]
	before_filter :correct_user,   only: [:edit, :update]
	before_filter :admin_user,     only: [:destroy, :new]

  
  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.followed_users.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end
  
  
  def show
	@user = User.find(params[:id])
	if correct_user_without_redirect
		@routines = @user.routines
	else
	    @routines = @user.routines.where(private: false)
	end
	
	@measurements = @user.measurements
	
	@complete_goals = @user.goals.where(complete: true)
	@incomplete_goals = @user.goals.where(complete: false)
  end
  
  def new
	@user = User.new
  end
  
  
  def index
    @users = User.search(params[:search])
  end
  
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Perfil actualizado"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "Usuario eliminado."
    redirect_to users_url
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
		UserMailer.registration_confirmation(@user).deliver  
		sign_in @user
		flash[:success] = "Bienvenido a SocialGym!"
		redirect_back_or @user
    else
      render 'new'
    end
  end
  
   private

    
	
	def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end
	def correct_user_without_redirect
      @user = User.find(params[:id])
      current_user?(@user)
    end
	def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
end
