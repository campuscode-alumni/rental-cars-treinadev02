class ManufacturersController < ApplicationController

    def index
        @manufacturers = Manufacturer.all
    end

    def show
        @manufacturer = Manufacturer.find(params[:id])
    end

    def new 
        @manufacturer = Manufacturer.new
    end

    def edit
        @manufacturer = Manufacturer.find(params[:id])
    end

    def update
        @manufacturer = Manufacturer.find(params[:id])
        if @manufacturer.update(manufacturers_params)
            redirect_to @manufacturer
        else
            render :new
        end
    end

    def create 
        manufacturer = Manufacturer.new(manufacturers_params)

        if manufacturer.save
            redirect_to manufacturer
        else
            render :new
        end
    end

    private 
    def manufacturers_params
        params.require(:manufacturer).permit(:name)
    end

end