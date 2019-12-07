class SubsidiariesController < ApplicationController

    before_action :authenticate_user!
    before_action :authenticate_admin, only: [:new, :create, :edit, :update, :destroy]
    before_action :find_subsidiary, only: [:show, :edit, :update, :destroy]

    def index
        @subsidiaries = Subsidiary.all
    end
        
    def new
        @subsidiary = Subsidiary.new
    end

    def show
    end

    def edit
    end

    def update 
        if @subsidiary.update(subsidiary_params)
            flash[:notice] = 'Filial alterada com sucesso'
            redirect_to @subsidiary
        else
            render :edit
        end
    end
    
    def create
        @subsidiary = Subsidiary.new(subsidiary_params)
        if @subsidiary.save
            flash[:notice] = 'Filial criada com sucesso'
            redirect_to @subsidiary
        else
            render :new
        end
    end

    def destroy
        @subsidiary.destroy
        flash[:notice] = 'Filial removida com sucesso'
        redirect_to subsidiaries_url
    end
    
    private 
    
    def subsidiary_params
        params.require(:subsidiary).permit(:name, :cnpj, :address)
    end

    def find_subsidiary
        @subsidiary = Subsidiary.find(params[:id])
    end
    
    def authenticate_admin
        redirect_to root_path unless current_user.admin?
    end             
end     