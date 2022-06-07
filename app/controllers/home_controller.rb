class HomeController < ApplicationController
  def index
    @flights = Flight.page(params[:page]).per(10)
  end
end
