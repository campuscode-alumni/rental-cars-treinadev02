class CarModelsController < ApplicationController
    def index
        @car_models = CarModel.all
    end

    def show
        @car_model = CarModel.find(params[:id])
    end

    def new
        @car_model = CarModel.new
        @manufacturers = Manufacturer.all 
        @car_categories = CarCategory.all 
    end

    def edit
        @car_model = CarModel.find(params[:id])
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
        @car_model = CarModel.find(params[:id])
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
end