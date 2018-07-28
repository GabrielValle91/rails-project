class SessionsController < ApplicationController
  def new

  end

  def create

  end

  def logout
    if logged_in?
      session.clear
    end
    redirect_to root_url
  end
end
