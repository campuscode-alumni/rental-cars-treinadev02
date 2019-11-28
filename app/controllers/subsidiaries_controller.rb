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
    
    def create
        @subsidiary = Subsidiary.new(get_params)
        if @subsidiary.save
            redirect_to @subsidiary
        else
            render :new
        end
    end
    
    private 
    
    def get_params
        params.require(:subsidiary).permit(:name, :cnpj, :address)
    end
            
end     