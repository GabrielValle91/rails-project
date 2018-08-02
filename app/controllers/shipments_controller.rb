class ShipmentsController < ApplicationController
  before_action :user_auth
  before_action :make_shipment, only: [:new]
  before_action :correct_user, only: [:show, :edit, :update]

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
    if !find_client || find_client.user != current_user
      flash[:notice] = "something went wrong, try again"
      redirect_to new_user_shipment_path(current_user)
      return
    end
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
    @location_shipper = @shipment.shipment_details.where(location_type: "shipper").first
    @location_consignee = @shipment.shipment_details.where(location_type: "consignee").first
    #raise @location_shipper.inspect
  end

  def update
    @shipment.update(shipment_params)
    redirect_to user_shipment_path(current_user, @shipment)
  end

  private

  def make_shipment
    @shipment = Shipment.new
  end

  def correct_user
    find_shipment
    if @shipment.user != current_user
      redirect_to user_shipments_path(current_user)
    end
  end

  def find_client
    if params[:shipment][:client_id] != ""
      Client.find(params[:shipment][:client_id])
    else
      return false
    end
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
