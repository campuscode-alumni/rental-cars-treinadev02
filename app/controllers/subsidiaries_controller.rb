class SubsidiariesController < ApplicationController
  def index
    @subsidiaries = Subsidiary.all
  end

  def show
    @subsidiary = Subsidiary.find(params[:id])
  end

  def new
    @subsidiary = Subsidiary.new
  end

  def edit
    @subsidiary = Subsidiary.find(params[:id])
  end

  def create
    @subsidiary = Subsidiary.create(subsidiary_params)

    if @subsidiary.save
      redirect_to @subsidiary
    else
      flash.now[:alert] = 'Você deve preencher todos os campos'
      render 'new'
    end
  end

  def update
    @subsidiary = Subsidiary.find(params[:id])
    if @subsidiary.update(subsidiary_params)
      flash[:notice] = 'Filial atualizada com sucesso'
      redirect_to @subsidiary
    else
      render :edit
    end
  end

  private

  def subsidiary_params
    params.require(:subsidiary).permit(:name, :cnpj, :address)
  end

end
