class ValoraciosController < ApplicationController
  def new
  	@valoracio = Valoracio.new
  end

  def create
  	@valoracio = Valoracio.new(create_params)
    @valoracio.usuari = usuari_actual
  	@valoracio.save
  end

  def index
    @valoracions = Valoracio.all
  end

  def show
  end

  def create_params
  		params.require(:valoracio).permit(:titol, :opinio, :punts, :pdi_id, :ruta_turistica_id)
    end
end
