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
    if params[:valoracio][:pdi_id] != ""
      redirect_to '/pdis/'+ params[:valoracio][:pdi_id].to_s
    else
      redirect_to '/ruta_turisticas/'+ params[:valoracio][:ruta_turistica_id].to_s
    end
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
