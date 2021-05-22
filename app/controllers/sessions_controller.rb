class SessionsController < ApplicationController
  def create
    @user = User.find_by(username: params[:username])
    if @user.nil?
      flash[:notice] = 'That user does not exist.'
      redirect_to login_path
    else
      session[:user_id] = @user.id
      redirect_to root_path
      flash[:notice] = "Welcome back, #{@user.name}."
    end
  end

  def destroy
    @current_user = session[:user_id] = nil
    redirect_to login_path
  end
end
