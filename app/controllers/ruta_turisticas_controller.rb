class RutaTuristicasController < ApplicationController
  def new
    @rt = RutaTuristica.new
    #@rt.pdis_rutaturisticas = PdisRutaturistica.new
    2.times { 
      @rt.pdis_rutaturisticas.build 
      #@rt.pdis_rutaturisticas.last.pdi = Pdi.new
      #@pdi_rt = PdisRutaturistica.new
      #@pdi_rt.pdi = Pdi.new
    }
  end

  def create
    @rt = RutaTuristica.new(create_params)
    @rt.usuari = usuari_actual


    # TODO posar això fora del controlador. Ha d'anar al model de ruta turística  
    ll = []
    llista = params[:ruta_turistica][:pdis_rutaturisticas_attributes].values
    cont = 0
    llista.each do |a|
      ll << PdisRutaturistica.new(:pdi_id => llista[cont].first[1].to_i)
      cont = cont + 1 
    end

    @rt.pdis_rutaturisticas = ll

    #PdisRutaturistica.first.pdis.map{|cs| cs.nom}

    @rt.save


    #@rt.el_meu_save(@pdis)

  end

  def show
  end

  def index
  end

  def edit
  end

  def update
  end
  
  def create_params
      #params.require(:ruta_turistica).permit(:nom, :temps,
       # :pdis_rutaturistica_attributes => [:nom])

    params.require(:ruta_turistica).permit(:nom, :temps,
       :pdis_rutaturistica_attributes => [:pdi])
  end
       

end
