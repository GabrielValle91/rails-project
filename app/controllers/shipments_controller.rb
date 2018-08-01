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
    if !params[:user_id]
      redirect_to new_user_shipment_path(current_user)
    end
  end

  def create
    @shipment = Shipment.create(shipment_params)
    @shipment.user = current_user

    if @shipment.save
      @shipment.update(shipment_params)
      redirect_to user_shipments_path(@shipment.user)
    else
      redirect_to new_shipment_path
    end
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
    params.require(:shipment).permit(:reference, :pickup_date, :delivery_date, :user_id, :client_name, :client_id, location_shipper: [:id, :company_name, :address1, :address2, :city, :state, :zip_code, :driver_id], location_consignee: [:id, :company_name, :address1, :address2, :city, :state, :zip_code, :driver_id])
  end

  def user_auth
    if !logged_in?
      redirect_to signin_url
    end
  end
end
