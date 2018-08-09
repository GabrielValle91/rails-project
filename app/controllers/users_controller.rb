class UsersController < ApplicationController
  def show
    @user = current_user
  end

  def new
    @user = User.new
  end

  def index
    @users = User.active_users
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      redirect_to new_user_url
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
end
