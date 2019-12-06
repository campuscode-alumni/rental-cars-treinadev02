class ManufacturersController < ApplicationController

    before_action :authenticate_user!
    before_action :authenticate_admin
    before_action :find_manufacturer, only: [:show, :edit, :update, :destroy]
    
    def index
        @manufacturers = Manufacturer.all
    end

    def show
    end

    def new 
        @manufacturer = Manufacturer.new
    end

    def edit
    end

    def update
        if @manufacturer.update(manufacturers_params)
            flash[:notice] = 'Fabricante atualizado com sucesso'
            redirect_to @manufacturer
        else
            render :edit
        end
    end

    def create 
        @manufacturer = Manufacturer.new(manufacturers_params)

        if @manufacturer.save
            flash[:notice] = 'Fabricante cadastrado com sucesso'
            redirect_to @manufacturer
        else
            render :new
        end
    end

    def destroy
        @manufacturer.destroy
        flash[:notice] = 'Fabricante removido com sucesso'
        redirect_to manufacturers_url
    end


    private 
    def manufacturers_params
        params.require(:manufacturer).permit(:name)
    end

    def find_manufacturer
        @manufacturer = Manufacturer.find(params[:id])
    end

    def authenticate_admin
        redirect_to root_path unless current_user.admin?
    end
end