class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @user_events = user_event_conditional(@user)
  end

  def user_event_conditional(user)
    if params[:time_filter].nil? || params[:time_filter] == 'all'
      user.events
    elsif params[:time_filter] == 'future'
      user.events.upcoming_events
    elsif params[:time_filter] == 'past'
      user.events.past_events
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Welcome, #{@user.name}."
      redirect_to root_path
    else
      redirect_to new_user_path
      flash[:warning] = 'That username is already taken'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :username)
  end
end
