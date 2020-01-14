class SessionsController < ApplicationController
  before_action :require_logout, except: [:destroy, :show]
  before_action :require_login, only: [:destroy, :show]
  def new
    @user = User.new
  end

  def create
    @user = User.find_by(email: params[:session][:email])
    if @user
      if @user.authenticate(params[:session][:password])
        login_as(@user, true)
        flash[:success] = 'You are now Logged in'
        redirect_to profile_path
      else
        @error = 'Invalid passord.'
        render :new
      end
    else
      @error = 'That email is not registered with us.'
      render :new
    end
  end

  def destroy
    forget_user
    flash[:success] = 'Logged out'
    redirect_to login_path
  end

  def show
    @user = User.find_by(id: session[:user_id])
    render 'users/show'
  end
end
