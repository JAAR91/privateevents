class ApplicationController < ActionController::Base
  def authenticate_user!
    if session[:user_id].nil?
      redirect_to login_path
    else
      @user = User.find(session[:user_id])
      redirect_to login_path if @user.nil?
    end
  end
end
