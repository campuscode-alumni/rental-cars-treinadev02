class SubsidiariesController < ApplicationController
  def index
    @subsidiaries = Subsidiary.all
  end

  def show
    @subsidiaries = Subsidiary.find(params[:id])
  end

  def new
    @subsidiaries = Subsidiary.new
  end

  def create
    @subsidiaries = Subsidiary.create(subsidiary_params)

    if @subsidiaries.save
      redirect_to @subsidiaries
    else
      render 'new'
    end
  end

  private

  def subsidiary_params
    params.require(:subsidiary).permit(:name, :cnpj, :address)
  end

end
