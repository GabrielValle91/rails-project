class LocationsController < ApplicationController
  before_action :user_auth
  before_action :make_location, only: [:new]
  before_action :correct_user, only: [:edit, :update, :show]
  before_action :redirect_if_not_nested_new, only: [:new, :create]
  before_action :redirect_if_not_nested_edit, only: [:edit, :update]
  before_action :redirect_if_not_nested_show, only: [:index]

  def index
    @locations = current_user.locations
  end

  def show
    respond_to do |format|
      format.html {render :show}
      format.json {render json: @location}
    end
  end

  def new
  end

  def create
    @location = Location.new(location_params)
    @location.user = current_user
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

  def redirect_if_not_nested_edit
    if !params[:user_id]
      redirect_to edit_user_location_path(current_user, @location)
    end
  end

  def redirect_if_not_nested_new
    if !params[:user_id]
      redirect_to new_user_location_path(current_user)
    end
  end

  def redirect_if_not_nested_show
    if !params[:user_id]
      redirect_to user_locations_path(current_user)
    end
  end

  def correct_user #user verification and location finding for show, edit, update methods
    find_location
    if @location.user.id != current_user.id
      redirect_to user_locations_path(current_user)
    end
  end

  def make_location
    @location = Location.new
  end

  def find_location
    @location = Location.find(params[:id])
  end

  def location_params
    params.require(:location).permit(:company_name, :address1, :address2, :city, :state, :zip_code, :user_id)
  end

  def user_auth
    if !logged_in?
      redirect_to signin_url
    end
  end
end
