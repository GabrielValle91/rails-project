class ItemsController < ApplicationController
  before_action :user_auth
  before_action :make_item, only: [:new, :create]
  before_action :find_item, only: [:show, :edit, :update]

  def index

  end

  def show
  end

  def new
  end

  def create
    @item.name = params[:item][:name]
    @item.description = params[:item][:description]
    if params[:item][:client_name]
      @item.client = Client.find_by(name: params[:item][:client_name])
    else
      @item.client = Client.find(params[:item][:client_id])
    end
    if @item.save
      redirect_to user_client_path(current_user, @item.client)
    else
      flash[:notice] = @item.errors.full_messages
      if params[:item][:client_name]
        redirect_to new_client_item_path(@item.client)
      else
        redirect_to new_item_path(@item)
      end
    end
  end

  def edit
  end

  def update

  end

  private

  def make_item
    @item = Item.new
  end

  def find_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:name, :client_id, :client_name)
  end

  def user_auth
    if !logged_in?
      redirect_to signin_url
    end
  end
end
