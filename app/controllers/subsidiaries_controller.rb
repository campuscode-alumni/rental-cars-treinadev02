class SubsidiariesController < ApplicationController

    def index
        @subsidiaries = Subsidiary.all
    end
        
    def new
        @subsidiary = Subsidiary.new
    end

    def show
        @subsidiary = Subsidiary.find(params[:id])
    end

    def edit
        @subsidiary = Subsidiary.find(params[:id])
    end

    def update 
        @subsidiary = Subsidiary.find(params[:id])
        if @subsidiary.update(subsidiary_params)
            redirect_to @subsidiary
        else
            render :new
        end
    end
    
    def create
        @subsidiary = Subsidiary.new(subsidiary_params)
        if @subsidiary.save
            redirect_to @subsidiary
        else
            render :new
        end
    end
    
    private 
    
    def subsidiary_params
        params.require(:subsidiary).permit(:name, :cnpj, :address)
    end
            
end     