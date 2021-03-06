class UsuarisController < ApplicationController
	def new
		@usuari = Usuari.new
    @paisos = Pais.all
  end

	def create
  		@usuari = Usuari.new(create_params)
      @usuari.punts = 0
      if params[:usuari][:coord_lat_browser].blank? || params[:usuari][:coord_lng_browser].blank?
        @usuari.coord_lat_browser = 0
        @usuari.coord_lng_browser = 0
      end

      @usuari.pais = Pais.find_by_id(params[:pais])
      @usuari.pais_residencias << PaisResidencia.new(:pais_id => params[:pais_residencia])

  		@usuari.save
  		# save! retorna una excepció. sense el signe d'admiració retorna un booleà i que @usuari té tots els errors @usuari.errors
  	  if @usuari.errors.count > 0
        @paisos = Pais.all
        render('new')
      else 
        # TODO redirigir a l'autèntica home
        redirect_to '/sessions/new'
        #redirect_to root_url, :notice => "Signed up!"
      end

  end

  def show
    @usuari = Usuari.find(params[:id])
  end

  def edit
    @usuari = Usuari.find(params[:id])
    @paisos = Pais.all
    if !@usuari.pais.nil?
      @pais_naixament = @usuari.pais.id
    end
    if !@usuari.pais_residencias.first.nil?
      @pais_residencia = @usuari.pais_residencias.order("created_at").last.pais_id
    end
  end

  def update
    # TODO - un usuari normal me l'updateja bé. Però un usuari de xarxa social no. només país de residència. potser tmb és culpa dels validates a Usuari?
    # TODO - o botó o guardar coords
    @usuari = Usuari.find(params[:id])
    @usuari.pais = Pais.find_by_id(params[:pais])
    if !PaisResidencia.where(:pais_id=>params[:pais_residencia], :usuari_id=>usuari_actual.id).exists?
      @usuari.pais_residencias << PaisResidencia.new(:pais_id => params[:pais_residencia])
    end
    @usuari.update(create_params)
  end

  def create_params
  	params.require(:usuari).permit(:nom, :cognom, :nom_usuari, :email, :password, :password_confirmation, :edat, :sexe, :coord_lat_browser, :coord_lng_browser)
  end

end
