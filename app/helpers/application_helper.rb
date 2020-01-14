require 'action_view'
require 'action_view/helpers'
module ApplicationHelper
  include ActionView::Helpers::DateHelper
  def current_user
    User.find_by(id: session[:user_id])
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
end
