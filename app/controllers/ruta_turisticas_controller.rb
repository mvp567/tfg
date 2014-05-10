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
    
    #mirar params si esta selected_pdi
    @rt = RutaTuristica.new(create_params)
    @rt.usuari = usuari_actual


    # TODO posar això fora del controlador. Ha d'anar al model de ruta turística  

    ll = []
    llista = params[:ruta_turistica][:pdis_rutaturisticas_attributes].values

    llista.each do |a|
      # ll << PdisRutaturistica.new(:pdi_id => llista[cont].first[1].to_i)
      
      if a.values[1] == "false" && !a.first[1].empty?
        selected_pdi = Pdi.find_by_nom(a.first[1])
        selected_pdi_id = selected_pdi.id
        ll << PdisRutaturistica.new(:pdi_id => selected_pdi_id)
      end
    end

    @rt.pdis_rutaturisticas = ll

    #PdisRutaturistica.first.pdis.map{|cs| cs.nom}

    @rt.save


    #@rt.el_meu_save(@pdis)
    # TODO, si salva pq la llista no està buida, anar a create correctament. Sino anar a no creada
    
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
