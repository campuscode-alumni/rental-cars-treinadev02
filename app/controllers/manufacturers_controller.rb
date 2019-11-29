class ManufacturersController < ApplicationController
  def index
    @manufacturers = Manufacturer.all
  end

  def show
    id = params[:id]
    @manufacturer = Manufacturer.find(id)
  end

  def new
    @manufacturer = Manufacturer.new
  end
  
  def create
    @manufacturer = Manufacturer.create(manufacturer_params)

    redirect_to @manufacturer
  end

  private

  def manufacturer_params
    params.require(:manufacturer).permit(:name)
  end
end
