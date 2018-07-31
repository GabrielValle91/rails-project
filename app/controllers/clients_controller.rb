class ClientsController < ApplicationController
  before_action :user_auth
  before_action :make_client, only: [:new, :create]
  before_action :correct_user, only: [:show, :edit, :update]

  def index
    if !params[:user_id]
      redirect_to user_clients_path(current_user)
    end
    @clients = current_user.clients
  end

  def show
    if !params[:user_id]
      redirect_to user_client_path(current_user, @client)
    end
  end

  def new
    if !params[:user_id]
      redirect_to new_user_client_path(current_user)
    end
  end

  def create
    if !params[:user_id]
      redirect_to new_user_client_path(current_user)
    end
    @client.name = params[:client][:name]
    @client.user_id = current_user.id
    if @client.valid?
      @client.save
      redirect_to user_clients_path(current_user)
    else
      flash[:notice] = "#{@client.errors.full_messages}"
      redirect_to new_user_client_path(current_user)
    end
  end

  def edit
    if !params[:user_id]
      redirect_to edit_user_client_path(current_user, @client)
    end
  end

  def update
    if !params[:user_id]
      redirect_to edit_user_client_path(current_user, @client)
    end
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

  def correct_user #user verification and client finding for show, edit, update methods
    find_client
    if @client.user.id != current_user.id
      redirect_to user_clients_path(current_user)
    end
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
