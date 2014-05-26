class CercadorsController < ApplicationController
  def index
  	tipus_pdi = "1"
  	tipus_rt = "2"
  	tipus_ciutat = "3"
  	tipus_pais = "4"
  	tipus_etiqueta = "5"
  	tipus_usuari = "6"

    @pdis = []
    @usuaris = []
    @rts = []

  	if params[:tipus] == tipus_pdi
      @pdis = Pdi.find(:all, :conditions => ['nom ILIKE ?', "%#{params[:cerca]}%"])
  	elsif params[:tipus] == tipus_rt
      @rts = RutaTuristica.find(:all, :conditions => ['nom ILIKE ?', "%#{params[:cerca]}%"])
  	elsif params[:tipus] == tipus_ciutat
  	  @pdis = Pdi.find(:all, :conditions => ['localitat ILIKE ?', "%#{params[:cerca]}%"])
      @pdis.each do |p|
        p.pdis_rutaturisticas.each do |rtp|
          @rts << rtp.ruta_turistica
        end
      end
      @rts = @rts.uniq
  	elsif params[:tipus] == tipus_pais
      @pdis = Pdi.find(:all, :conditions => ['pais ILIKE ?', "%#{params[:cerca]}%"])
      @pdis.each do |p|
        p.pdis_rutaturisticas.each do |rtp|
          @rts << rtp.ruta_turistica
        end
      end
      @rts = @rts.uniq
  	elsif params[:tipus] == tipus_etiqueta
      @pdis = Etiqueta.find(:all, :conditions => ['nom ILIKE ?', "%#{params[:cerca]}%"]).first.pdis
    elsif params[:tipus] == tipus_usuari
      @usuaris = Usuari.find(:all, :conditions => ['nom_usuari ILIKE ?', "%#{params[:cerca]}%"])  
  	end	

  end
end
