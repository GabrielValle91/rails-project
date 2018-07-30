class ShipmentsController < ApplicationController
  before_action :user_auth
  before_action :make_shipment, only: [:new]
  before_action :find_shipment, only: [:show, :edit, :update]

  def index
    @shipments = current_user.shipments
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
    params.require(:item).permit(:reference, :pickup_date, :deliver_date, :user_id)
  end

  def user_auth
    if !logged_in?
      redirect_to signin_url
    end
  end
end
