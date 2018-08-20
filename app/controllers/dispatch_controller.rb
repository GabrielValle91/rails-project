class DispatchController < ApplicationController
  before_action :user_auth
  def index
    @drivers = current_user.drivers
    @shipment = Shipment.new
  end

  def assignedshipments
    date = Time.strptime(params[:date], "%m-%d-%Y")
    @assigned_shipments = current_user.shipments.assigned_shipments(date.strftime("%m/%d/%Y"))
    render json: @assigned_shipments
  end

  def unassignedshipments
    @unassigned_shipments = current_user.shipments.unassigned_shipments.distinct
    render json: @unassigned_shipments
  end

  private

  def user_auth
    if !logged_in?
      redirect_to signin_url
    end
  end
end
