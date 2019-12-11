class CarsController < ApplicationController
  def index
  end

  def show
    @car = Car.find(params[:id])
  end

  def new
    @car = Car.new
    @car_models = CarModel.all
    @subsidiaries = Subsidiary.all
  end

  def create
    @car = Car.new(car_params)
    @car.save
    redirect_to @car
  end

  private

    def car_params
      params.require(:car).permit(:license_plate, :mileage, :color,
                                  :car_model_id, :subsidiary_id)
    end
end
