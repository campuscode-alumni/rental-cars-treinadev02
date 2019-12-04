class ClientsController < ApplicationController

    def index
        @clients = Client.all
    end

    def new
        @client = Client.new
    end

    def show 
        @client = Client.find(params[:id])
    end

    def edit
        @client = Client.find(params[:id])
    end

    def update
        @client = Client.find(params[:id])
        if @client.update(client_params)
            flash[:notice] = "Cliente atualizado com sucesso"
            redirect_to @client
        else
            render :edit
        end
    end

    def create
        @client = Client.new(client_params)
        if @client.save
            flash[:notice]= 'Cliente cadastrado com sucesso'
            redirect_to @client
        else
            render :new
        end
    end




    private 

    def client_params
        params.require(:client).permit(:name, :cpf, :email)
    end

    
end