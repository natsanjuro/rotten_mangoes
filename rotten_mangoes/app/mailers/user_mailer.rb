class UserMailer < ActionMailer::Base
  default from: "rottenmangoes@example.com"

  def goodbye_email(user)
    @user = user
    @url  = 'http://example.com/login'
    mail(to: @user.email, subject: 'Sorry to see you go!')
    
  end
end
