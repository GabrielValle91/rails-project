class ItemsController < ApplicationController
  before_action :user_auth
  before_action :make_item, only: [:new]
  before_action :find_item, only: [:show]

  def index
    if params[:client_id]
      @items = current_client.items
    else
      @items = current_user.items
    end
  end

  def show
    if !params[:client_id]
      if correct_user
        redirect_to user_client_item_path(current_user, @item.client, @item)
      else
        redirect_to user_items_path(current_user)
      end
    end
  end

  def new
  end

  def create
    #raise params.inspect
    if !params[:client_id]
      if Client.find(params[:item][:client_id]).user == current_user
        @item = Item.new(item_params)
        if @item.save
          redirect_to user_client_items_path(current_user, @item.client)
        else
          flash[:notice] = @item.errors.full_messages
          redirect_to new_user_client_item_path(current_user, @item.client)
        end
      else
        redirect_to new_user_item_path(current_user)
      end
    else
      if current_client.user == current_user
        @item = Item.new(item_params)
        if @item.save
          redirect_to user_client_items_path(current_user, current_client)
        else
          flash[:notice] = @item.errors.full_messages
          redirect_to new_user_client_item_path(current_user, @item.client)
        end
      else
        redirect_to new_user_item_path(current_user)
      end
    end
  end

  def edit
    #raise params.inspect
    if correct_user
      if !params[:client_id]
        redirect_to edit_client_item_path(@item.client, @item)
      end
    else
      redirect_to user_items_path(current_user)
    end
  end

  def update
    if correct_user
      if @item.update(item_params)
        redirect_to user_client_path(current_user, @item.client)
      else
        flash[:notice] = @item.errors.full_messages
        redirect_to edit_client_item_path(@item.client)
      end
    else
      redirect_to user_items_path(current_user)
    end
  end

  private

  def correct_user
    find_item
    if @item.client.user == current_user
      return true
    else
      return false
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
