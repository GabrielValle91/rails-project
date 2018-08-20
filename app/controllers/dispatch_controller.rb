class DispatchController < ApplicationController
  before_action :user_auth
  def index
    @drivers = current_user.drivers
    @assigned_shipments = current_user.shipments.today_shipments
    @unassigned_shipments = current_user.shipments.unassigned_shipments
  end

  def assignedshipments
    @assigned_shipments = current_user.shipments.today_shipments
    date = Time.strptime("08/19/2018", "%m/%d/%Y")
    test = current_user.shipments.assigned_shipments(date.strftime("%m/%d/%Y"))
    raise test.inspect
    render json: @assigned_shipments
  end

  private

  def user_auth
    if !logged_in?
      redirect_to signin_url
    end
  end
end
