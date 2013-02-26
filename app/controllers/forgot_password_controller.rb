class ForgotPasswordController < ApplicationController
  def index
    if !params[:h].nil? && !params[:user_id].nil? && !User.find(params[:user_id]).nil?
      if params[:h] == forgot_password_code(User.find(params[:user_id]))
        @user_id = params[:user_id]
        render 'new_password'
      else
        flash.now[:error] = 'Invalid or expired forgot password url'
      end
    end
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

  def change_password
    @user = User.find(params[:forgot_password][:hidden])
    @user.password = params[:forgot_password][:password]
    @user.password_confirmation = params[:forgot_password][:password_confirmation]
    @user.increment("new_password_counter")

    if @user.save
      flash[:success] = "Password successfully changed!"
      redirect_to signin_path
    else
      error_message = @user.errors.full_messages.join(" ")
      flash[:error] = "Error while changing password.#{error_message}"
      redirect_to :back
    end

  end


  def send_password_link(user)
    UserMailer.send_password_reset(user,forgot_password_code(user))
  end

  #move to helper
  def forgot_password_code(user, date = Date.today)
    Digest::SHA256.hexdigest("#{user.id}#{date}#{user.new_password_counter}")
  end
end
