class ValoraciosController < ApplicationController
  def new
  	@valoracio = Valoracio.new
  end

  def create
    if params[:valoracio][:pdi_id] != ""
  	  @valoracio = ValoracioPdi.new(create_params)
    else
      @valoracio = ValoracioRt.new(create_params)
    end

    @valoracio.usuari = usuari_actual

    @valoracio.punts = params[:punts].to_i * 2

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
