class DispatchController < ApplicationController
  before_action :user_auth
  def index
    @drivers = current_user.drivers
    @assigned_shipments = current_user.shipments.today_shipments
  end

  def assignedshipments
    date = Time.strptime("08/19/2018", "%m/%d/%Y")
    @assigned_shipments = current_user.shipments.assigned_shipments(date.strftime("%m/%d/%Y"))
    render json: @assigned_shipments
  end

  def unassignedshipments
    @unassigned_shipments = current_user.shipments.unassigned_shipments
    render json: @unassigned_shipments
  end

  private

  def user_auth
    if !logged_in?
      redirect_to signin_url
    end
  end
end
