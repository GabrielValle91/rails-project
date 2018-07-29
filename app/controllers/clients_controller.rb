class ClientsController < ApplicationController
  before_action :user_auth
  before_action :make_client, only: [:new, :create]
  before_action :find_client, only: [:show, :edit, :update]

  def index
    @clients = current_user.clients
  end

  def show
  end

  def new
  end

  def create
    @client.name = params[:client][:name]
    @client.user_id = current_user.id
    if @client.valid?
      @client.save
      redirect_to clients_path
    else
      flash[:notice] = "#{@client.errors.full_messages}"
      redirect_to new_user_client_path(current_user)
    end
  end

  def edit
  end

  def update
    if @client.update(client_params)
      redirect_to user_client_path(current_user, @client)
    else
      flash[:notice] = "#{@client.errors.full_messages}"
      redirect_to edit_user_client_path(current_user, @client)
    end
  end

  private

  def make_client
    @client = Client.new
  end

  def find_client
    @client = Client.find(params[:id])
  end

  def client_params
    params.require(:client).permit(:name, :user_id)
  end

  def user_auth
    if !logged_in?
      redirect_to signin_url
    end
  end
end
