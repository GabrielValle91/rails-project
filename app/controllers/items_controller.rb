class ItemsController < ApplicationController
  before_action :user_auth
  before_action :make_item, only: [:new]
  before_action :find_item, only: [:show, :edit, :update]

  def index
    if params[:client_id]
      @items = current_client.items
    else
      @items = current_user.items
    end
  end

  def show
  end

  def new
  end

  def create
    @item = Item.create(item_params)
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
    if @item.update(item_params)
      redirect_to user_client_path(current_user, @item.client)
    else
      flash[:notice] = @item.errors.full_messages
      if params[:item][:client_name]
        redirect_to edit_client_item_path(@item.client)
      else
        redirect_to edit_item_path(@item)
      end
    end
  end

  private

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
