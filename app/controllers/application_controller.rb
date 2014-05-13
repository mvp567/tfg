class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def usuari_actual
  	@usuari_actual = Usuari.find_by_id(session[:usuari_id])
  end

end
