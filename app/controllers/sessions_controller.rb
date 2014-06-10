class SessionsController < ApplicationController
  def new
  end

  def create

    #render :text => request.env["omniauth.auth"].to_yaml  
    #auth = request.env["omniauth.auth"]

    #a = Authentication.where(:provider => auth['provider'], :uid => auth['uid']).first
    
    #if a.nil?
     # usu = Usuari.crear_amb_omniauth(auth)
    #else
    #  usu = a.usuari
    #end
    
    #session[:usuari_id] = usu.id
    #flash[:notice] = "Authentication successful yay."
    #redirect_to 'pdis/index'

	  
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