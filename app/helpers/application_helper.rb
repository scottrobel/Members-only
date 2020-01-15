require 'action_view'
require 'action_view/helpers'
module ApplicationHelper

  private

  include ActionView::Helpers::DateHelper
  def current_user
    if @current_user ||= User.find_by(id: session[:user_id])
      @current_user
    elsif (user_id = cookies.signed[:user_id]) && (remembered_token = cookies[:remember_token])
      if (remembered_user = User.find_by(id: user_id)) && (remembered_user.check_token(remembered_token))
        session[:user_id] = user_id
        @current_user = remembered_user
      end
    end 
  end

  def require_login
    unless logged_in?
      flash[:error] = "you must be signed in to see that page!"
      redirect_to login_path
    end
  end


  def logged_in?
    current_user
  end

  def navbar_link_class(link_helper)
    if request.fullpath == link_helper
      'active'
    else
      ''
    end
  end

  def require_logout
    if logged_in?
      flash[:error] = "You are already logged in!"
      redirect_to profile_path
    end
  end

  def login_as(user, remember_boolean = false)
    session[:user_id] = user.id
    @current_user = user
    remember_user(user) if remember_boolean
  end

  def remember_user(user)
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.new_token
  end

  def forget_user
    session.delete(:user_id)
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
    @user = nil
  end

  def logout
    forget_user
    session.delete(:user_id)
    @current_user = nil
  end

  def require_own_post
    unless Post.find_by(id: params[:id]).user == current_user
      flash[:error] = "that is not your post"
      redirect_to posts_path
    end
  end
end
