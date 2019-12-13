class RentalsController < ApplicationController
    
    before_action :authenticate_user!
    before_action :find_rental, only: [:show, :edit, :update, :destroy]

    def index
        @rentals = Rental.all
        @cars = Car.all
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
        @cars = @rental.car_category.cars.availble
        #@cars = @rental.car_category.cars.where('subsidiary_id = :subsidiary_id and status = :status', { subsidiary_id: current_user.subsidiary_id, status: :availble} )
    end

    def create
        @rental = Rental.new(rental_params)
        @rental.reservation_code = SecureRandom.hex(5).upcase
        @rental.subsidiary_id = current_user.subsidiary
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

    def search
         @rentals = Rental.where('reservation_code like ?', "%#{params[:q]}%") 

         render :index
    end

    def start
        @rental = Rental.find(params[:id])
        @rental.in_progress!

        @car = Car.find(params[:rental][:car_id])
        @car.unavailble!

        @rental.create_car_rental(car: @car, price: @car.car_category.price)

        flash[:notice] = 'Locação iniciada com sucesso'

        redirect_to @rental
    end
    
    private 

    def rental_params
        params.require(:rental).permit(:start_date, :end_date, :client_id, :car_category_id)
    end

    def find_rental
        @rental = Rental.find(params[:id])
    end
end