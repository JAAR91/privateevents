class UsersController < ApplicationController
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
      flash[:notice] = 'That username is already taken'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:name, :username)
  end
end
