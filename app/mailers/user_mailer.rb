class UserMailer < ActionMailer::Base
default from: "juan.vash@gmail.com" 
  def registration_confirmation(user)  
	@user = user
    mail(:to => user.email, :subject => "Registered", :from => "eifion@asciicasts.com")  
  end
  
  def password_reset(user)
	  @user = user
	  mail :to => user.email, :subject => "Password Reset"
  end
end
