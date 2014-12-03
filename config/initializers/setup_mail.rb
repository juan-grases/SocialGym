ActionMailer::Base.smtp_settings = {  
  :address              => "smtp.gmail.com",  
  :port                 => 587,  
  :domain               => "socialgym.com",  
  :user_name            => "juan.vash",  
  :password             => "jagg1234",  
  :authentication       => "plain",  
  :enable_starttls_auto => true  
}  