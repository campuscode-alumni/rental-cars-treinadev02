class SubsidiariesController < ApplicationController
  def index
    @subsidiaries = Subsidiary.all
  end

  def show
    @subsidiaries = Subsidiary.find(params[:id])
  end
end
