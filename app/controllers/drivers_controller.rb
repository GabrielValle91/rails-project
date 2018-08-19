class DriversController < ApplicationController
  before_action :user_auth
  before_action :make_driver, only: [:new, :create]
  before_action :correct_user, only: [:show, :edit, :update]
  before_action :redirect_if_not_nested_new, only: [:new, :create]
  before_action :redirect_if_not_nested_edit, only: [:edit, :update]
  before_action :redirect_if_not_nested_show, only: [:index]

  def index
    @drivers = current_user.drivers
  end

  def show
    respond_to do |format|
      format.html {render :show}
      format.json {render json: @driver}
    end
  end

  def new
  end

  def create
    @driver.user_id = current_user.id
    if @driver.update(driver_params)
      redirect_to user_drivers_path(current_user)
    else
      flash[:notice] = @driver.errors.full_messages
      redirect_to new_user_driver_path(current_user)
    end
  end

  def edit
  end

  def update
    if @driver.update(driver_params)
      redirect_to user_drivers_path(current_user)
    else
      flash[:notice] = @driver.errors.full_messages
      redirect_to edit_user_driver_path(current_user, @driver)
    end
  end

  private

  def redirect_if_not_nested_new
    if !params[:user_id]
      redirect_to new_user_driver_path(current_user)
    end
  end

  def redirect_if_not_nested_edit
    if !params[:user_id]
      redirect_to edit_user_driver_path(current_user, @driver)
    end
  end

  def redirect_if_not_nested_show
    if !params[:user_id]
      redirect_to user_drivers_path(current_user)
    end
  end

  def make_driver
    @driver = Driver.new
  end

  def find_driver
    @driver = Driver.find(params[:id])
  end

  def correct_user #user verification and client finding for show, edit, update methods
    find_driver
    if @driver.user.id != current_user.id
      redirect_to user_drivers_path(current_user)
    end
  end

  def driver_params
    params.require(:driver).permit(:name, :license, :driver_type, :status)
  end

  def user_auth
    if !logged_in?
      redirect_to signin_url
    end
  end
end
