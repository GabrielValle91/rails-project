class ItemsController < ApplicationController
  before_action :user_auth
  before_action :make_item, only: [:new]
  before_action :find_item, only: [:show]
  before_action :redirect_if_wrong_user_edit, only: [:edit, :update]

  def index
    if params[:client_id]
      if current_client.user == current_user
        @items = current_client.items
      else
        @items = current_user.items
      end
    else
      @items = current_user.items
    end
  end

  def show
    if !params[:client_id] || !correct_user
      redirect_to user_items_path(current_user)
    elsif !params[:client_id]
      redirect_to user_client_item_path(current_user, @item.client, @item)
    end
  end

  def new
    if params[:client_id] && current_client && current_client.user != current_user
      redirect_to new_user_item_path(current_user)
    end
  end

  def create
    if find_client.user != current_user
      redirect_to new_user_item_path(current_user)
      return
    end
    @item = Item.new(item_params)
    if @item.save
      redirect_to user_client_items_path(current_user, @item.client)
    else
      flash[:notice] = @item.errors.full_messages
      redirect_to new_user_client_item_path(current_user, @item.client)
    end
  end

  def edit
    if !params[:client_id]
      redirect_to edit_client_item_path(@item.client, @item)
    end
    if @item.client.user != current_user
      redirect_to new_user_item_path(current_user)
    end
  end

  def update
    if @item.update(item_params)
      redirect_to user_client_items_path(current_user, @item.client)
    else
      flash[:notice] = @item.errors.full_messages
      redirect_to edit_client_item_path(@item.client)
    end
  end

  private

  def find_client
    if params[:item][:client_id]
      Client.find(params[:item][:client_id])
    else
      Client.find_by(name: params[:item][:client_name])
    end
  end

  def correct_user
    find_item
    if @item.client.user == current_user
      return true
    else
      return false
    end
  end

  def redirect_if_wrong_user_edit
    find_item
    if @item.client.user != current_user
      redirect_to user_items_path(current_user)
    end
  end

  def make_item
    @item = Item.new
  end

  def find_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:name, :description, :client_id, :client_name)
  end

  def user_auth
    if !logged_in?
      redirect_to signin_url
    end
  end
end
