class SessionsController < ApplicationController
  include ApplicationHelper
  before_action :not_signed_in, except: [:destroy, :show]
  before_action :is_logged_in, only: [:destroy, :show]
  def new
    @user = User.new
  end

  def create
    @user = User.find_by(email: params[:session][:email])
    if @user
      if @user.authenticate(params[:session][:password])
        session[:user_id] = @user.id
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
    session.delete(:user_id)
    @user = nil
    flash[:success] = 'Logged out'
    redirect_to login_path
  end

  def show
    @user = User.find_by(id: session[:user_id])
    render 'users/show'
  end

  private

  def is_logged_in
    unless logged_in?
      flash[:error] = "you must be signed in to see that page!"
      redirect_to login_path
    end
  end

  def not_signed_in
    if logged_in?
      redirect_to current_user
    end
  end
end
