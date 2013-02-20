class ForgotPasswordController < ApplicationController
  def index

  end

  def create
    @user = User.find_by_email(params[:forgot_password][:email])
    if @user
      send_password_link(@user).deliver
      flash.now[:error] = 'An email has been sent!'
    else
      flash.now[:error] = 'Invalid email!'
    end
    render 'index'
  end

  def send_password_link(user)
    UserMailer.send_password_reset(user,forgot_password_code(user))
  end

  #move to helper
  def forgot_password_code(user, date = Date.today)
    Digest::SHA256.hexdigest("#{user.id}#{date}")
  end
end
