class SessionsController < ApplicationController
  def new
  end

  def create
	usu = Usuari.find_by_nom_usuari(params[:nom_usuari])
  	#if Usuari.authenticate(usu)
      #flash[:notice] = "debuug - autenticant"
    #end
    if usu && usu.authenticate(params[:password])
      session[:usuari_id] = usu.id
      # TODO redirigir a l'autèntica home
      redirect_to ({:controller => "home", :action => "index"})
    else
      flash[:notice] =  "Nom d\'usuari invàlid o contrasenya errònea"
      render "new"
    end
  end

  #TODO tancar sessió
  def destroy
    session[:usuari_id] = nil
    redirect_to root_url, :notice => "Logged out!"
  end
end