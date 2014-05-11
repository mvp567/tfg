class RutaTuristicasController < ApplicationController
  def new
    @rt = RutaTuristica.new
    2.times { 
      @rt.pdis_rutaturisticas.build
      @rt.pdis_rutaturisticas.last.pdi = Pdi.new
    }
  end

  def create

    @rt = RutaTuristica.new(create_params)
    @rt.usuari = usuari_actual


    # TODO posar això fora del controlador. Ha d'anar al model de ruta turística  
    ll = []
    llista = params[:ruta_turistica][:pdis_rutaturisticas_attributes].values

    llista.each do |a|
      pdi_seleccionat = a.values[0]["id"]
      ll << PdisRutaturistica.new(:pdi_id => pdi_seleccionat)
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
    @rts = RutaTuristica.all
  end

  def edit

    @rt = RutaTuristica.find(params[:id])
    byebug
    # carregar pdis
  end

  def update
    @rt = RutaTuristica.find(params[:id])

    # TODO mirar si se n'han tret o afegit. crear o treure instàncies a pdis_rutaturist
    @rt.update(create_params)
  end
  
  def create_params
    params.require(:ruta_turistica).permit(:nom, :temps,
       :pdis_rutaturistica_attributes => [:pdi])
  end
       

end
