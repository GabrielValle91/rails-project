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
    @client = Client.new
    @client.name = params[:client][:name]
    @client.user_id = current_user.id
    if @client.valid?
      @client.save
      redirect_to clients_path
    else
      flash[:notice] = "#{@client.errors.full_messages}"
      redirect_to new_client_path
    end
  end

  def edit

  end

  def update

  end

  private

  def client_params
    params.require(:client).permit(:name, :user_id)
  end

  def user_auth
    if !logged_in?
      redirect_to signin_url
    end
  end
end
