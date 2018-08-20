class DispatchController < ApplicationController
  before_action :user_auth
  def index
    @drivers = current_user.drivers
    @assigned_shipments = current_user.shipments.today_shipments
    @unassigned_shipments = current_user.shipments.unassigned_shipments
  end

  private

  def user_auth
    if !logged_in?
      redirect_to signin_url
    end
  end
end
