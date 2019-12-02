class CarCategoriesController < ApplicationController
  def index
    @car_categories = CarCategory.all
  end

  def show
    @car_categories = CarCategory.find(params[:id])
  end

  def new
    @car_categories = CarCategory.new
  end

  def create
    @car_categories = CarCategory.create(car_category_params)

    if @car_categories.save
      redirect_to @car_categories
    else
      render 'new'
    end
  end

  private

  def car_category_params
    params.require(:car_category).permit(:name, :daily_rate, :car_insurance, :third_party_insurance)
  end

end
