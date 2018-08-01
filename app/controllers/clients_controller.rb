class ClientsController < ApplicationController
  before_action :user_auth
  before_action :make_client, only: [:new]
  before_action :correct_user, only: [:show, :edit, :update]
  before_action :redirect_if_not_nested_new, only: [:new, :create]
  before_action :redirect_if_not_nested_edit, only: [:edit, :update]
  before_action :redirect_if_not_nested_show, only: [:index, :show]

  def index
    @clients = current_user.clients
  end

  def show
  end

  def new
  end

  def create
    @client = Client.new(client_params)
    @client.user = current_user
    if @client.save
      redirect_to user_clients_path(current_user)
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

  def redirect_if_not_nested_show
    if !params[:user_id]
      redirect_to user_clients_path(current_user)
    end
  end

  def redirect_if_not_nested_new
    if !params[:user_id]
      redirect_to new_user_client_path(current_user)
    end
  end

  def redirect_if_not_nested_edit
    if !params[:user_id]
      redirect_to edit_user_client_path(current_user, @client)
    end
  end

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
    params.require(:client).permit(:name)
  end

  def user_auth
    if !logged_in?
      redirect_to signin_url
    end
  end
end
