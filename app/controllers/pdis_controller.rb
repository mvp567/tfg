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
    # primer: creo Localització amb la localització de google maps
    # @pdi.localitzacio = amb l'objecte acabat de crear
    # per les etiquetes, miro si la taula etiqueta la té, sino la creo, i creo link etiqueta-pdi a la taula etiquetes_pdis

    @etiquetes = params[:etiquetes]

    @pdi.el_meu_save(@etiquetes)
  	#@pdi.save
    
  end

  def show
  end

  def create_params
  		params.require(params[:tipus].downcase.to_sym).permit(
        :nom, :observacions, :horari, :telefon, :web, :preu_aprox, :nivell_preu, :forquilles, :estrelles,
        :adreca, :localitat, :pais, :codi_postal, :coord_lat, :coord_lng)
  end


end
