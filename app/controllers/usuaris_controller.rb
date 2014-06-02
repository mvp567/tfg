class UsuarisController < ApplicationController
	def new
		@usuari = Usuari.new
  end

	def create
  		@usuari = Usuari.new(create_params)
      @usuari.punts = 0
      if params[:coord_lat_browser].blank? || params[:coord_lng_browser].blank?
        @usuari.coord_lat_browser = 0
        @usuari.coord_lng_browser = 0
      end
  		@usuari.save
  		# save! retorna una excepció. sense el signe d'admiració retorna un booleà i que @usuari té tots els errors @usuari.errors
  	  if @usuari.errors.count > 0
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
  end

  def update
    @usuari = Usuari.find(params[:id])
    @usuari.update(create_params)
  end

  def create_params
  	params.require(:usuari).permit(:nom, :cognom, :nom_usuari, :email, :password, :password_confirmation, :edat, :sexe, :coord_lat_browser, :coord_lng_browser)
  end

end
