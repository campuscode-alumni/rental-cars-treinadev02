class CarsController < ApplicationController

    def index
    @cars = Car.all        
    end

    def show
        @car = Car.find(params[:id])
    end

    def new
        @car = Car.new
        @subsidiaries = Subsidiary.all
        @car_models = CarModel.all
    end

    def edit
        @car = Car.find(params[:id])
        @subsidiaries = Subsidiary.all
        @car_models = CarModel.all
    end

    def create
        @car = Car.new car_params
        if @car.save 
            flash[:notice] = 'Carro cadastrado com sucesso'
            redirect_to @car
        else
            @subsidiaries = Subsidiary.all
            @car_models = CarModel.all
            
            flash[:notice] = 'Erro'
            render :new
        end
    end

    def update
        @car = Car.find(params[:id])
        if @car.update car_params
            flash[:notice] = 'Carro alterado com sucesso'
            redirect_to @car
        else
            @subsidiaries = Subsidiary.all
            @car_models = CarModel.all
            
            render :edit
        end
    end

    private 
    
    def car_params
        params.require(:car).permit(:license_plate, :color, :mileage, :subsidiary_id, :car_model_id)
    end
end