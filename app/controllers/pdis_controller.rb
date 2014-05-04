class PdisController < ApplicationController

  def new
    if params[:tipus_pdi] != nil
      @pdi = params[:tipus_pdi].constantize.new
      @tipus_valor = params[:tipus_pdi]

    end
  end

  def create
  	# TODO flten les classes_ a la view i aqui

    # TODO favorits pdi-usuari

  	@pdi = params[:tipus].constantize.new(create_params)
    @pdi.usuari = usuari_actual
    @etiquetes = params[:etiquetes]

    @pdi.el_meu_save(@etiquetes)
  	# @pdi.save
  end

  def edit
    @pdi = Pdi.find(params[:id])
  end

  def update
    @pdi = Pdi.find(params[:id])

    #if 
      @pdi.update(update_params)
      #redirect_to @pdi ## PROBLEM no existeix hotel_url
    #else
     # render 'edit'
    #end
  end

  def show
  end

  def index
    @pdis = Pdi.all
  end

  def create_params
  		params.require(params[:tipus].downcase.to_sym).permit(
        :nom, :observacions, :horari, :telefon, :web, :preu_aprox, :nivell_preu, :forquilles, :estrelles,
        :adreca, :localitat, :pais, :codi_postal, :coord_lat, :coord_lng)
  end

  def update_params
      params.require(params[:tipus].downcase.to_sym).permit(
        :nom, :observacions, :horari, :telefon, :web, :preu_aprox, :nivell_preu, :forquilles, :estrelles)
  end
end
