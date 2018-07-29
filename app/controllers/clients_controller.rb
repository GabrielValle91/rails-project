class ClientsController < ApplicationController
  before_action :user_auth

  def index
    @clients = current_user.clients
  end

  def show

  end

  def new
    @client = Client.new
  end

  def create

  end

  def edit

  end

  def update

  end

  private

  def user_auth
    if !logged_in?
      redirect_to signin_url
    end
  end
end
