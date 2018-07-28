class SessionsController < ApplicationController
  def new
  end

  def create
    if session[:user_id]
      redirect_to user_path(User.find(session[:id]))
    else
      @user = User.find_by(username: params[:username])
      if @user.authenticate(params[:password])
        session[:user_id] = @user.id
        redirect_to user_path(@user)
      else
        redirect_to signin_url, notice: "incorrect password"
      end
    end
  end

  def logout
    if logged_in?
      session.clear
    end
    redirect_to root_url
  end
end
