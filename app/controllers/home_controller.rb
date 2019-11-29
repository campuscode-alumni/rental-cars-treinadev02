class HomeController < ApplicationController
  def index
    @fabricantes = Manufacturer.all
  end
end
