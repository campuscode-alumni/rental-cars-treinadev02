class HomeController < ApplicationController
  def index
    @manufacturers = Manufacturer.all
  end
end
