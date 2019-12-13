class CarCategoriesController < ApplicationController

    before_action :authenticate_user!
    before_action :authenticate_admin, only: [:new, :create, :edit, :update, :destroy]
    before_action :find_car_category, only: [:show, :edit, :update, :destroy]

    def index
        @car_categories = CarCategory.all
    end

    def show 
    end

    def new
        @car_category = CarCategory.new
    end

    def edit
    end

    def update
        if @car_category.update(get_params)
            flash[:notice] = 'Categoria de carro alterada com sucesso'
            redirect_to @car_category
        else
            render :edit
        end
    end

    def create 
        @car_category = CarCategory.new(get_params)
        if @car_category.save
            flash[:notice] = 'Categoria de carro criada com sucesso'
            redirect_to @car_category
        else
            render :new
        end
    end

    def destroy
        @car_category.destroy
        flash[:notice] = 'Categoria de carro removida com sucesso'
        redirect_to car_categories_url
    end

    private 
    def get_params
        params.require(:car_category).permit(:name, :daily_rate, :car_insurance, :third_party_insurance)
    end

    def find_car_category
        @car_category = CarCategory.find(params[:id])
    end

    def authenticate_admin
        redirect_to root_path unless current_user.admin?
    end
end