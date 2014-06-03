class SessionsController < ApplicationController
  def new
  end

  def create
	  usu = Usuari.find_by_nom_usuari(params[:nom_usuari])
    if usu && usu.authenticate(params[:password])
      session[:usuari_id] = usu.id
      redirect_to ({:controller => "home", :action => "index"})
    else
      flash[:notice] =  "Nom d\'usuari invàlid o contrasenya errònea"
      render "new"
    end
  end

  def destroy
    @usuari_actual = nil
    session[:usuari_id] = nil
    redirect_to root_url
  end
end