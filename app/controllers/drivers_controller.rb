class DriversController < ApplicationController
  before_action :user_auth
  before_action :make_driver, only: [:new]
  before_action :find_driver, only: [:show, :edit, :update]

  def index
    @drivers = Driver.all
  end

  def show
  end

  def new
  end

  def create
    @driver = Driver.new(driver_params)
    if @driver.save
      redirect_to drivers_path
    else
      flash[:notice] = @driver.errors.full_messages
      redirect_to new_driver_path
    end
  end

  def edit
  end

  def update
    if @driver.update(driver_params)
      redirect_to drivers_path
    else
      flash[:notice] = @driver.errors.full_messages
      redirect_to new_driver_path
    end
  end

  private

  def make_driver
    @driver = Driver.new
  end

  def find_driver
    @driver = Driver.find(params[:id])
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
