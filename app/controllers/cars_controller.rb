class CarsController < ApplicationController

    before_action :authenticate_user!
    before_action :authenticate_admin, only: [:new, :create, :edit, :update, :destroy]
    before_action :find_car, only: [:show, :edit, :update, :destroy]

    def index
    @cars = Car.all        
    end

    def show
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

    def find_car
        @car = Car.find(params[:id])
    end
    
    def authenticate_admin
        redirect_to root_path unless current_user.admin?
    end   
end