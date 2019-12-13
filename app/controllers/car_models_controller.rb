class CarModelsController < ApplicationController
    
    before_action :authenticate_user!
    before_action :authenticate_admin, only: [:new, :create, :edit, :update, :destroy]
    before_action :find_car_model, only: [:show, :edit, :update, :destroy]
    
    def index
        @car_models = CarModel.all
    end

    def show
    end

    def new
        @car_model = CarModel.new
        @manufacturers = Manufacturer.all 
        @car_categories = CarCategory.all 
    end

    def edit
        @manufacturers = Manufacturer.all 
        @car_categories = CarCategory.all 
    end

    def create
        @car_model = CarModel.new car_model_params
        if @car_model.save
            flash[:notice] = 'Modelo registrado com sucesso'
            redirect_to @car_model
        else
            @manufacturers = Manufacturer.all 
            @car_categories = CarCategory.all 

            render :new
        end 
    end

    def update
        if @car_model.update car_model_params
            flash[:notice] = 'Modelo alterado com sucesso'
            redirect_to @car_model
        else
            @manufacturers = Manufacturer.all 
            @car_categories = CarCategory.all 

            render :new
        end 
    end

    private 

    def car_model_params
        params.require(:car_model).permit(:name, :year, :fuel_type, :motorization, :manufacturer_id, :car_category_id)
    end

    def find_car_model
        @car_model = CarModel.find(params[:id])
    end
    
    def authenticate_admin
        redirect_to root_path unless current_user.admin?
    end  
end