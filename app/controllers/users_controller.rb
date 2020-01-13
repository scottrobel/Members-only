class UsersController < ApplicationController
  include ApplicationHelper
  before_action :not_signed_in, only: [:new, :create]
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

  def not_signed_in
    if logged_in?
      redirect_to current_user
    end
  end
end
