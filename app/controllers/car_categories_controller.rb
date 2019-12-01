class CarCategoriesController < ApplicationController
  def index
    @car_categories = CarCategory.all
  end

  def show
    @car_categories = CarCategory.find(params[:id])
  end

end
