class ClientsController < ApplicationController

    before_action :find_client, only: [:show, :edit, :update, :destroy]

    def index
        @clients = Client.all
    end

    def new
        @client = Client.new
    end

    def show 
    end

    def edit
    end

    def update
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

    def destroy
        @client.destroy 
        flash[:notice] = 'Cliente removido com sucesso'
        redirect_to clients_url
    end

    private 

    def client_params
        params.require(:client).permit(:name, :cpf, :email)
    end

    def find_client
        @client = Client.find(params[:id])
    end

end