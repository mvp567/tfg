class ValoraciosController < ApplicationController
  def new
  	@valoracio = Valoracio.new
  end

  def create
  	@valoracio = Valoracio.new(create_params)
  	@valoracio.save
  end

  def index
  end

  def show
  end

  def create_params
  		params.require(:valoracio).permit(:titol, :opinion, :punts)
    end
end
