class DispatchController < ApplicationController
  before_action :user_auth
  def index
    @drivers = current_user.drivers
    @shipments = current_user.shipments.today_shipments
    @unassigned_shipments = current_user.shipment_details.unassigned_shipments
    raise @unassigned_shipments.inspect
  end

  private

  def user_auth
    if !logged_in?
      redirect_to signin_url
    end
  end
end
