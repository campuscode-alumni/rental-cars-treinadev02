class RentalsController < ApplicationController
    
    before_action :authenticate_user!
    before_action :find_rental, only: [:show, :edit, :update, :destroy]

    def index
        @rentals = Rental.all
    end

    def new
        @rental = Rental.new()
        @clients = Client.all 
        @car_categories = CarCategory.all 
    end

    def edit
        @clients = Client.all 
        @car_categories = CarCategory.all 
    end

    def show
    end

    def create
        @rental = Rental.new(rental_params)
        if @rental.save
            flash[:notice] = 'Locação agendada com sucesso'
            redirect_to @rental            
        else
            @clients = Client.all 
            @car_categories = CarCategory.all 
            render :new
        end
    end

    def update
        if @rental.update rental_params
            flash[:notice] = 'Locação alterada com sucesso'
            redirect_to @rental            
        else
            @clients = Client.all 
            @car_categories = CarCategory.all 
            render :edit
        end
    end
    
    private 

    def rental_params
        params.require(:rental).permit(:start_date, :end_date, :client_id, :car_category_id)
    end

    def find_rental
        @rental = Rental.find(params[:id])
    end

end