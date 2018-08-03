class SessionsController < ApplicationController
  def new
  end

  def create
    if session[:user_id]
      redirect_to user_path(User.find(session[:id]))
    else
      if auth_hash = request.env["omniauth.auth"]
        user_name = auth_hash[:info][:name]
        user_email = auth_hash[:info][:email]
        if @user = User.find_by(email: user_email)
          session[:user_id] = @user.id
          redirect_to user_path(@user)
        else
          @user = User.new(username: user_name, email: user_email, password: SecureRandom.hex)
          if @user.save
            session[:user_id] = @user.id
            redirect_to user_path(@user)
          else
            redirect_to signin_url, notice: "something went wrong, please try again"
          end
        end
      else
        @user = User.find_by(username: params[:username])
        if @user && @user.authenticate(params[:password])
          session[:user_id] = @user.id
          redirect_to user_path(@user)
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
