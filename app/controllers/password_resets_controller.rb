# encoding: utf-8
class PasswordResetsController < ApplicationController
	def create
	  user = User.find_by_email(params[:email])
	  user.send_password_reset if user
	  redirect_to root_url, :notice => "Email sent with password reset instructions."
	end

	def edit
	  @user = User.find_by_password_reset_token!(params[:id])
	end

	def update
	  @user = User.find_by_password_reset_token!(params[:id])
	  if @user.password_reset_sent_at < 2.hours.ago
		redirect_to new_password_reset_path, :alert => "El cambio de contraseña ha expirado."
	  elsif @user.update_attributes(params[:user])
		redirect_to root_url, :success => "Tu contraseña ha sido cambiada exitosamente"
	  else
		render :edit
	  end
	end
end
