module ApplicationHelper
  def logged_in?
    !!session[:user_id]
  end

  def current_user
    @current_user ||= User.find_by_id(session[:user_id]) if !!session[:user_id]
  end

  def alert_color(type)
    
    return 'alert-success' if type == 'success'
    return 'alert-info' if type == 'notice'
    return 'alert-warning' if type == 'warning'
    return 'alert-danger' if type == 'danger'    
  end
end
