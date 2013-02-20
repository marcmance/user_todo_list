class UserMailer < ActionMailer::Base
  default from: "mmance@signpost.com"

  def send_password_reset(user, code)
    @user = user
    @code = code
    mail(:to => user.email, :subject => "ToDoList Password Reset")
  end
end
