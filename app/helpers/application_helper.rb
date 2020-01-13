module ApplicationHelper
  def current_user
    User.find_by(id: session[:user_id])
  end

  def signed_in
    unless logged_in?
      redirect_to login_path
    end
  end

  def logged_in?
    current_user
  end

  def nav_link_class(link_helper)
    if current_page?(link_helper)
      'active'
    else
      ''
    end
  end
end
