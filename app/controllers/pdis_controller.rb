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

    @pdi.lonlat = 'POINT(2.1789019999999937 41.385514)'

    @pdi.el_meu_save(@etiquetes)
  	# @pdi.save
  end

  def edit
    @pdi = Pdi.find(params[:id])
  end

  def update
    @pdi = Pdi.find(params[:id])

    #if 
    byebug
      @pdi.update(update_params)
      #redirect_to @pdi ## PROBLEM no existeix hotel_url
    #else
     # render 'edit'
    #end
  end

  def show
    @pdi = Pdi.find(params[:id])
    @valoracions = @pdi.valoracios

    #@puntsPDI = @pdi.calcula_punts
    #@puntsPDI = @pdi.punts

    #TODO each time valoració new, s'actualitza aquest camp a la bd
   
    #@puntsPDI = 0
    #@valoracions.each do |v|
     # @puntsPDI += (v.punts * Usuari.find_by_id(v.usuari_id).punts/1000)
    #end
     # @puntsPDI /= @valoracions.count
  end

  def index

    # provant la cerca per proximitat de pdi
    #@eo = Pdi.where(:lonlat => 'POINT(2.1789019999999937 41.385514)').first

    #@eo = Pdi.where("ST_DWithin(ST_GeographyFromText('SRID=4326;POINT(' || pdis.coord_lng|| ' ' || pdis.coord_lat || ')'
    #    ),ST_GeographyFromText('SRID=4326;POINT(2.1789019999999937 41.385514)'),200)")

    @eo = Pdi.close_to(41.385514,2.1789019999999937)


    # Provant cerca per nom de pdi
    @pdis_by_nom = []
    if params[:search]
      @pdis_by_nom = Pdi.find(:all, :conditions => ['nom ILIKE ?', "%#{params[:search]}%"])
    else
      @pdis_by_nom = Pdi.all
    end

    # Provant cerca per ciutat
    @pdis_ciutat = []
    if params[:search_ciutat]
      @pdis_ciutat = Pdi.find(:all, :conditions => ['localitat ILIKE ?', "%#{params[:search_ciutat]}%"])
    else
      @pdis_ciutat = Pdi.all
    end



    @usuari_actual = usuari_actual

    # Per l'autocomplete dels pdis
    cercar = params[:request_term]
     if cercar.nil?
      @pdis = Pdi.all
    else
      @pdis = Pdi.where("nom ILIKE ?", "%#{cercar}%" )
    end
     
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json => @pdis.to_json }
    end



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
