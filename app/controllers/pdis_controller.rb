class PdisController < ApplicationController

  def new
    if usuari_actual.nil?
      redirect_to pdis_path, :notice => "Has d'estar registrat per poder crear punts d'interès."
    else
      if params[:tipus_pdi] != nil
        @pdi = params[:tipus_pdi].constantize.new
        @tipus_valor = params[:tipus_pdi]
        @classes_botigues = ClasseBotiga.all
        @classes_entreteniment = ClasseEntreteniment.all
        @classes_museus = ClasseMuseu.all
        @classes_restaurants = ClasseRestaurant.all
      end
    end
  end

  def create
  	@pdi = params[:tipus].constantize.new(create_params)
    @pdi.usuari = usuari_actual
    @pdi.usuari_modificador = usuari_actual
    @etiquetes = params[:etiquetes]

    if params[:tipus] == 'Botiga' 
      @pdi.classe_botiga = ClasseBotiga.find_by_id(params[:classe_botiga])
    elsif params[:tipus] == 'Entreteniment'
      @pdi.classe_entreteniment = ClasseEntreteniment.find_by_id(params[:classe_entreteniment])
    elsif params[:tipus] == 'Museu'
      @pdi.classe_museu = ClasseMuseu.find_by_id(params[:classe_museu])
    elsif params[:tipus] == 'Restaurant'
      @pdi.classe_restaurant = ClasseRestaurant.find_by_id(params[:classe_restaurant])
    end
  
    #@pdi.lonlat = 'POINT(2.1789019999999937 41.385514)'

    @pdi.el_meu_save(@etiquetes)
  	# @pdi.save

    if @pdi.errors.count > 0
        render('new')
      else 
        redirect_to pdi_path(@pdi)
      end
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

    if params[:tipus] == 'Botiga' 
      @pdi.classe_botiga = ClasseBotiga.find_by_id(params[:classe_botiga])
    elsif params[:tipus] == 'Entreteniment'
      @pdi.classe_entreteniment = ClasseEntreteniment.find_by_id(params[:classe_entreteniment])
    elsif params[:tipus] == 'Museu'
      @pdi.classe_museu = ClasseMuseu.find_by_id(params[:classe_museu])
    elsif params[:tipus] == 'Restaurant'
      @pdi.classe_restaurant = ClasseRestaurant.find_by_id(params[:classe_restaurant])
    end

    @pdi.el_meu_save(@etiquetes)

    if @pdi.update(update_params)
      redirect_to pdi_path(@pdi)
    else
      render 'edit'
    end
  end

  def show
    @pdi = Pdi.find(params[:id])
    @url_compartir = "https://www.facebook.com/sharer.php?u=http://146.148.11.157/pdis/" + @pdi.id.to_s + "&t=Berry Tour - Punt d'interès"
    @valoracions = @pdi.valoracios
    if !@pdi.fotos_grans.nil?
      @fotos = @pdi.fotos_grans.split ","
    else
      @fotos = []
    end

    @horari = nil

    if !@pdi.horari.blank?
  
      @horari = JSON.parse @pdi.horari

      @dll, @dt, @dc, @dj, @dv, @ds, @du = nil

      @horari["periods"].each do |p|
        if p["close"].nil? 
          @horari = nil
        else
          if p["close"]["day"] == 0
            @du = p["open"]["time"] + '-' + p["close"]["time"]
            @du.insert(2, ':').insert(8, ':')

          elsif p["close"]["day"] == 1
            @dll = p["open"]["time"] + '-' + p["close"]["time"]
            @dll.insert(2, ':').insert(8, ':')

          elsif p["close"]["day"] == 2
            @dt = p["open"]["time"] + '-' + p["close"]["time"]
            @dt.insert(2, ':').insert(8, ':')

          elsif p["close"]["day"] == 3
            @dc = p["open"]["time"] + '-' + p["close"]["time"]
            @dc.insert(2, ':').insert(8, ':')

          elsif p["close"]["day"] == 4
            @dj = p["open"]["time"] + '-' + p["close"]["time"]
            @dj.insert(2, ':').insert(8, ':')

          elsif p["close"]["day"] == 5
            @dv = p["open"]["time"] + '-' + p["close"]["time"]
            @dv.insert(2, ':').insert(8, ':')

          elsif p["close"]["day"] == 6
            @ds = p["open"]["time"] + '-' + p["close"]["time"]
            @ds.insert(2, ':').insert(8, ':')
          end
        end

        if @dll.nil?
          @dll = "Tancat"
        elsif @dt.nil?
          @dt = "Tancat"
        elsif @dc.nil?
          @dc = "Tancat"
        elsif @dj.nil?
          @dj = "Tancat"
        elsif @dv.nil?
          @dv = "Tancat"
        elsif @ds.nil?
          @ds = "Tancat"
        elsif @du.nil?
          @du = "Tancat"
        end
      end
  
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


      if !usuari_actual.nil? && Favorit.where(:pdi_id=>@pdi.id, :usuari_id=>usuari_actual.id).exists?
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
        @pdis = Pdi.close_to(usuari_actual.coord_lat_browser, usuari_actual.coord_lng_browser, 10000).distance_to(usuari_actual.coord_lat_browser, usuari_actual.coord_lng_browser)
        @restaurants = Restaurant.close_to(usuari_actual.coord_lat_browser, usuari_actual.coord_lng_browser, 10000).distance_to(usuari_actual.coord_lat_browser, usuari_actual.coord_lng_browser)
        @botigues = Botiga.close_to(usuari_actual.coord_lat_browser, usuari_actual.coord_lng_browser, 10000).distance_to(usuari_actual.coord_lat_browser, usuari_actual.coord_lng_browser)
        @museus = Museu.close_to(usuari_actual.coord_lat_browser, usuari_actual.coord_lng_browser, 10000).distance_to(usuari_actual.coord_lat_browser, usuari_actual.coord_lng_browser)
        @monuments = Monument.close_to(usuari_actual.coord_lat_browser, usuari_actual.coord_lng_browser, 10000).distance_to(usuari_actual.coord_lat_browser, usuari_actual.coord_lng_browser)
        @discoteques = Discoteca.close_to(usuari_actual.coord_lat_browser, usuari_actual.coord_lng_browser, 10000).distance_to(usuari_actual.coord_lat_browser, usuari_actual.coord_lng_browser)
        @entreteniment = Entreteniment.close_to(usuari_actual.coord_lat_browser, usuari_actual.coord_lng_browser, 10000).distance_to(usuari_actual.coord_lat_browser, usuari_actual.coord_lng_browser)
        @hotels = Hotel.close_to(usuari_actual.coord_lat_browser, usuari_actual.coord_lng_browser, 10000).distance_to(usuari_actual.coord_lat_browser, usuari_actual.coord_lng_browser)
        @vistes = Vista.close_to(usuari_actual.coord_lat_browser, usuari_actual.coord_lng_browser, 10000).distance_to(usuari_actual.coord_lat_browser, usuari_actual.coord_lng_browser)
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
    if usuari_actual.nil?
      pdi = params[:pdi_id]
      redirect_to pdi_path(pdi)
    else
      pdi = Pdi.find(params[:pdi_id])
      f = Favorit.new
      f.pdi = pdi
      f.usuari = usuari_actual
      pdi.favorits << f
      usuari_actual.favorits << f
      redirect_to pdi_path(pdi)
    end
  end

  def des_favorit
    if usuari_actual.nil?
      pdi = params[:pdi_id]
      redirect_to pdi_path(pdi)
    else
      pdi = params[:pdi_id]
      f = Favorit.where(:pdi_id=>pdi, :usuari_id=>usuari_actual.id).first
      f.destroy
      redirect_to pdi_path(pdi)
    end
  end

  def destroy
    pdi = Pdi.find(params[:pdi_id])
    
    if (pdi.pdis_rutaturisticas.count.zero? && pdi.valoracios.count.zero?)
      pdi.destroy
      flash[:notice_verd] =  "Punt d'interès esborrat."
      redirect_to pdis_path
    else
      flash[:notice] =  "Aquest punt d'interès no es pot esborrar perquè té valoracions o està inclòs en alguna ruta turística."
      redirect_to pdi_path(pdi)
    end
  end

  def create_params
  		params.require(params[:tipus].downcase.to_sym).permit(
        :nom, :observacions, :horari, :fotos_petites, :fotos_grans, :telefon, :web, :preu_aprox, :nivell_preu, :forquilles, :estrelles,
        :adreca, :localitat, :pais, :codi_postal, :coord_lat, :coord_lng, :icone, :place_reference, :classe_botiga, :classe_entreteniment, :classe_museu, :classe_restaurant)
  end

  def update_params
      params.require(params[:tipus].downcase.to_sym).permit(
        :nom, :observacions, :horari, :telefon, :web, :preu_aprox, :nivell_preu, :forquilles, :estrelles, :classe_botiga, :classe_entreteniment, :classe_museu, :classe_restaurant)
  end
end
