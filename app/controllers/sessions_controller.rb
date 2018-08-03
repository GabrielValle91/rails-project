class SessionsController < ApplicationController
  def new
  end

  def create
    if session[:user_id]
      redirect_to user_path(User.find(session[:id]))
    else
      if auth_hash = request.env["omniauth.auth"]
        @user = User.find_or_create_by_omniauth(auth_hash)
        session[:user_id] = @user.id
        redirect_to root_url
      else
        @user = User.find_by(username: params[:username])
        if @user && @user.authenticate(params[:password])
          session[:user_id] = @user.id
          redirect_to root_url
        else
          redirect_to signin_url, notice: "incorrect username/password combination"
        end
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
