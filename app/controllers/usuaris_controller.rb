class UsuarisController < ApplicationController
	def new
		@usuari = Usuari.new
  end

	def create
  		@usuari = Usuari.new(create_params)
  		@usuari.save
  		# save! retorna una excepció. sense el signe d'admiració retorna un booleà i que @usuari té tots els errors @usuari.errors
  	  if @usuari.errors.count > 0
        render('new')
      else 
        # TODO redirigir a l'autèntica home
        redirect_to '/demo/index'
        #redirect_to root_url, :notice => "Signed up!"
      end

  end

  def show
    @usuari = Usuari.find(params[:id])
  end

  	def create_params
  		params.require(:usuari).permit(:nom, :cognom, :nom_usuari, :email, :password, :password_confirmation, :edat, :sexe)
    end
end
