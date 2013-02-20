class SessionsController < ApplicationController
  def new
    if signed_in?
      redirect_to current_user
    end
  end

  def create
    user = User.find_by_email(params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      sign_in user
      redirect_to user
      #redirect_to user_path(user)
    else
      flash.now[:error] = 'Invalid email/password combination'
      render 'new'
    end

  end

  def destroy
    sign_out
    flash.now[:error] = 'You have signed out'
    render 'new'
  end
end
