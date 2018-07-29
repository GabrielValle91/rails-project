class ShipmentsController < ApplicationController
  before_action :user_auth
  before_action :make_shipment, only: [:new]
  before_action :find_shipment, only: [:show, :edit, :update]

  def index

  end

  def show

  end

  def new
  end

  def create

  end

  def edit
  end

  def update

  end

  private

  def make_shipment
    @shipment = Shipment.new
  end

  def find_shipment
    @shipment = Shipment.find(params[:id])
  end

  def shipment_params
    params.require(:item).permit(:name, :description, :client_id, :client_name)
  end

  def user_auth
    if !logged_in?
      redirect_to signin_url
    end
  end
end
