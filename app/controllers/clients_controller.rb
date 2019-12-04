class ClientsController < ApplicationController
  def index
  end

  def new
    @client = Client.new
  end

  def show
    @client = Client.find(params[:id])
  end

  def create
    @client = Client.new(client_params)

    if @client.save
      redirect_to @client
    else
      flash.now[:alert] = 'Você deve preencher todos os campos'
      render :new
    end
  end

  private

    def client_params
      params.require(:client).permit(:name, :cpf, :email)
    end

end
