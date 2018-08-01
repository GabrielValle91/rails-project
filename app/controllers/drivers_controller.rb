class DriversController < ApplicationController
  before_action :user_auth
  before_action :make_driver, only: [:new, :create]
  before_action :correct_user, only: [:show, :edit, :update]

  def index
    if !params[:user_id]
      redirect_to user_drivers_path(current_user)
      return
    end
    @drivers = current_user.drivers
  end

  def show
    if !params[:user_id]
      redirect_to user_driver_path(current_user, @driver)
    end
  end

  def new
    if !params[:user_id]
      redirect_to new_user_driver_path(current_user)
    end
  end

  def create
    if !params[:user_id]
      redirect_to new_user_driver_path(current_user)
      return
    end
    @driver.user_id = current_user.id
    if @driver.update(driver_params)
      redirect_to user_drivers_path(current_user)
    else
      flash[:notice] = @driver.errors.full_messages
      redirect_to new_user_driver_path(current_user)
    end
  end

  def edit
    if !params[:user_id]
      redirect_to edit_user_driver_path(current_user, @driver)
    end
  end

  def update
    if !params[:user_id]
      redirect_to edit_user_driver_path(current_user, @driver)
      return
    end
    if @driver.update(driver_params)
      redirect_to user_drivers_path(current_user)
    else
      flash[:notice] = @driver.errors.full_messages
      redirect_to edit_user_driver_path(current_user, @driver)
    end
  end

  private

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
    params.require(:driver).permit(:name, :license, :driver_type)
  end

  def user_auth
    if !logged_in?
      redirect_to signin_url
    end
  end
end
