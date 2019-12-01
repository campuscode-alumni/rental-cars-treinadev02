class CarCategoriesController < ApplicationController

    def index
        @car_categories = CarCategory.all
    end

    def show 
        @car_category = CarCategory.find(params[:id])
    end

    def new
        @car_category = CarCategory.new
    end

    def edit
        @car_category = CarCategory.find(params[:id])
    end

    def update
        @car_category = CarCategory.find(params[:id])
        if @car_category.update(get_params)
            redirect_to @car_category
        else
            render :new
        end
    end

    def create 
        @car_category = CarCategory.new(get_params)
        if @car_category.save
            redirect_to @car_category
        else
            render :new
        end
    end

    private 
    def get_params
        params.require(:car_category).permit(:name, :daily_rate, :car_insurance, :third_party_insurance)
    end

end