class UsersController < ApplicationController
  before_action :require_logout, only: [:new, :create]
  before_action :require_login, only: [:show]
  def show
    @user = User.find_by(id: params[:id])
    unless @user
      redirect_to login_path
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Sign up successful"
      redirect_to profile_path
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :username, :password, :password_confirmation)
  end
end
