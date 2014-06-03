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
    @pdi.usuari_modificador = usuari_actual
    @etiquetes = params[:etiquetes]
    #@pdi.lonlat = 'POINT(2.1789019999999937 41.385514)'

    @pdi.el_meu_save(@etiquetes)
  	# @pdi.save
  end

  def edit

    if usuari_actual.nil?
      error = "Has d'estar registrat per poder editar el punt d\'interès."
      redirect_to pdis_path, :notice => error
    else
      @pdi = Pdi.find(params[:id])
      @etiquetes = ""
      @pdi.etiqueta.each do |et|
        @etiquetes += et.nom + ","
      end
  end
  end

  def update
    @pdi = Pdi.find(params[:id])
    @etiquetes = params[:etiquetes]
    @pdi.usuari_modificador = usuari_actual
    @pdi.el_meu_save(@etiquetes)

    #if 
    ##@pdi.update(update_params)
      #redirect_to @pdi ## PROBLEM no existeix hotel_url
    #else
     # render 'edit'
    #end
  end

  def show
    @pdi = Pdi.find(params[:id])
    @valoracions = @pdi.valoracios
    if !@pdi.fotos_grans.nil?
      @fotos = @pdi.fotos_grans.split ","
    else
      @fotos = []
    end

    if !@pdi.horari.blank?
      @horari = JSON.parse @pdi.horari
    else
      @horari = "-"
    end

    #@puntsPDI = @pdi.calcula_punts
    #@puntsPDI = @pdi.punts

    #TODO each time valoració new, s'actualitza aquest camp a la bd
   
    #@puntsPDI = 0
    #@valoracions.each do |v|
     # @puntsPDI += (v.punts * Usuari.find_by_id(v.usuari_id).punts/1000)
    #end
     # @puntsPDI /= @valoracions.count

    # Mostrar pdis per proximitat 
    @pdis_propers = []
    if !@pdi.coord_lat.blank? && !@pdi.coord_lng.blank?
      @pdis_propers = Pdi.close_to(@pdi.coord_lat, @pdi.coord_lng, 500)
    end
     
     # Mostrar rutes que inclouen aquest pdi
      @rts_from_pdi = []
      @pdi.pdis_rutaturisticas.each do |rtp|
          @rts_from_pdi << rtp.ruta_turistica
      end

      # TODO si existeix favorit: pdi-usuari, llavors @es_favorit = true
      if Favorit.where(:pdi_id=>@pdi.id, :usuari_id=>usuari_actual.id).exists?
        @es_favorit = true
      end
  end

  def index
    # Per l'autocomplete dels pdis
    cercar = params[:request_term]

    if cercar.nil?
      # TODO order by created_at
      if usuari_actual.nil? || usuari_actual.coord_lat_browser == "0" || usuari_actual.coord_lng_browser == "0"
        @pdis = Pdi.all
        @restaurants = Restaurant.all
        @botigues = Botiga.all
        @museus = Museu.all
        @monuments = Monument.all
        @discoteques = Discoteca.all
        @entreteniment = Entreteniment.all
        @hotels = Hotel.all
        @vistes = Vista.all
      else
        @pdis = Pdi.close_to(usuari_actual.coord_lat_browser, usuari_actual.coord_lng_browser, 2000).distance_to(usuari_actual.coord_lat_browser, usuari_actual.coord_lng_browser)
        @restaurants = Restaurant.close_to(usuari_actual.coord_lat_browser, usuari_actual.coord_lng_browser, 2000).distance_to(usuari_actual.coord_lat_browser, usuari_actual.coord_lng_browser)
        @botigues = Botiga.close_to(usuari_actual.coord_lat_browser, usuari_actual.coord_lng_browser, 2000).distance_to(usuari_actual.coord_lat_browser, usuari_actual.coord_lng_browser)
        @museus = Museu.close_to(usuari_actual.coord_lat_browser, usuari_actual.coord_lng_browser, 2000).distance_to(usuari_actual.coord_lat_browser, usuari_actual.coord_lng_browser)
        @monuments = Monument.close_to(usuari_actual.coord_lat_browser, usuari_actual.coord_lng_browser, 2000).distance_to(usuari_actual.coord_lat_browser, usuari_actual.coord_lng_browser)
        @discoteques = Discoteca.close_to(usuari_actual.coord_lat_browser, usuari_actual.coord_lng_browser, 2000).distance_to(usuari_actual.coord_lat_browser, usuari_actual.coord_lng_browser)
        @entreteniment = Entreteniment.close_to(usuari_actual.coord_lat_browser, usuari_actual.coord_lng_browser, 2000).distance_to(usuari_actual.coord_lat_browser, usuari_actual.coord_lng_browser)
        @hotels = Hotel.close_to(usuari_actual.coord_lat_browser, usuari_actual.coord_lng_browser, 2000).distance_to(usuari_actual.coord_lat_browser, usuari_actual.coord_lng_browser)
        @vistes = Vista.close_to(usuari_actual.coord_lat_browser, usuari_actual.coord_lng_browser, 2000).distance_to(usuari_actual.coord_lat_browser, usuari_actual.coord_lng_browser)
      end

    else
      # per l'autocomplete
      @pdis = Pdi.where("nom ILIKE ?", "%#{cercar}%" )
    end
     
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json => @pdis.to_json }
    end

  end

  def favorit
    pdi = Pdi.find(params[:pdi_id])
    f = Favorit.new
    f.pdi = pdi
    f.usuari = usuari_actual
    pdi.favorits << f
    usuari_actual.favorits << f
    redirect_to pdi_path(pdi)
  end

  def des_favorit
    pdi = params[:pdi_id]
    f = Favorit.where(:pdi_id=>pdi, :usuari_id=>usuari_actual.id).first
    f.destroy
    redirect_to pdi_path(pdi)
  end

  def destroy
    pdi = Pdi.find(params[:pdi_id])
    
    if pdi.pdis_rutaturisticas.count.zero? && pdi.valoracios.count.zero?
      pdi.destroy
      redirect_to pdis_path
    else
      redirect_to pdi_path(pdi) #amb un notice de q no es pot esborrar
    end
  end

  def create_params
  		params.require(params[:tipus].downcase.to_sym).permit(
        :nom, :observacions, :horari, :fotos_petites, :fotos_grans, :telefon, :web, :preu_aprox, :nivell_preu, :forquilles, :estrelles,
        :adreca, :localitat, :pais, :codi_postal, :coord_lat, :coord_lng, :icone, :place_reference)
  end

  def update_params
      params.require(params[:tipus].downcase.to_sym).permit(
        :nom, :observacions, :horari, :telefon, :web, :preu_aprox, :nivell_preu, :forquilles, :estrelles)
  end
end
