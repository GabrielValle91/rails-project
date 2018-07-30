class LocationsController < ApplicationController
  before_action :user_auth
  before_action :make_location, only: [:new]
  before_action :find_location, only: [:edit, :update, :show]

  def index
    @locations = Location.all
  end

  def show
  end

  def new
    raise params.inspect
  end

  def create
    @location = Location.new(location_params)
    if @location.save
      redirect_to locations_path
    else
      flash[:notice] = @location.errors.full_messages
      redirect_to new_location_path
    end
  end

  def edit
  end

  def update
    if @location.update(location_params)
      redirect_to locations_path
    else
      flash[:notice] = @location.errors.full_messages
      redirect_to edit_location_path(@location)
    end
  end
  private

  def make_location
    @location = Location.new
  end

  def find_location
    @location = Location.find(params[:id])
  end

  def location_params
    params.require(:location).permit(:company_name, :address1, :address2, :city, :state, :zip_code)
  end

  def user_auth
    if !logged_in?
      redirect_to signin_url
    end
  end
end
