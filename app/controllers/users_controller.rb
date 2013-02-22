class UsersController < ApplicationController

  before_filter :signed_in_user, only: [:show]
  before_filter :correct_user,   only: [:show]
  before_filter :admin_user, only: [:index,:make_admin,:remove_admin]

  def index
    @users = User.order("id").all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  def show
    @user = User.find(params[:id])
    @task = Task.new

    params[:edit] == "true" ? @edit = true :

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        sign_in(@user)
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  def make_admin
    @user = User.find(params[:id])
    @user.update_attribute(:user_type, "admin")
    redirect_to users_path
  end

  def remove_admin
    @user = User.find(params[:id])
    @user.update_attribute(:user_type, "standard")
    redirect_to users_path
  end

  private

  def signed_in_user
    if !signed_in?
      redirect_to signin_url
    end
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(signin_url) unless current_user?(@user) || current_user.admin?
  end

  def admin_user
    redirect_to(signin_url) unless current_user.admin?
  end
end
