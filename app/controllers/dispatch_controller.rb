class DispatchController < ApplicationController
  before_action :user_auth
  def index

  end

  private

  def user_auth
    if !logged_in?
      redirect_to signin_url
    end
  end
end
