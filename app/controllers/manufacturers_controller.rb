class ManufacturersController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin
  before_action :set_manufacturer, only: [:show, :edit, :update]

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

  def create
    @manufacturer = Manufacturer.new(manufacturer_params)

    if @manufacturer.save
      redirect_to @manufacturer
    else
      flash.now[:alert] = 'Você deve preencher todos os campos'
      render :new
    end
  end

  def update
    if @manufacturer.update(manufacturer_params)
      flash[:notice] = 'Fabricante atualizada com sucesso'
      redirect_to @manufacturer
    else
      render :edit
    end
  end

  private

  def set_manufacturer
    @manufacturer = Manufacturer.find(params[:id])
  end

  def manufacturer_params
    params.require(:manufacturer).permit(:name)
  end

  def authorize_admin
    unless current_user.admin?
      flash[:notice] = 'Você não tem autorização para realizar esta ação'
      redirect_to root_path
    end
  end
end
