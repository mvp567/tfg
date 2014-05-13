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

    # TODO si pdi_seleccionat no existeix com a pdi. proposar-li a l'usuari de crear-lo. i redirigir-lo a la pàgina de pdi_create
    ordreRuta = 1
    llista.each do |a|
      pdi_seleccionat = a.values[1]["id"]
      ll << PdisRutaturistica.new(:pdi_id => pdi_seleccionat, :ordre => ordreRuta)
      ordreRuta = ordreRuta + 1
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
    # carregar pdis
  end

  def update
    @rt = RutaTuristica.find(params[:id])

    # TODO mirar si se n'han tret o afegit. crear o treure instàncies a pdis_rutaturist
    byebug
    @rt.update(update_params)
  end
  
  def create_params
    params.require(:ruta_turistica).permit(:nom, :temps,
       :pdis_rutaturistica_attributes => [:pdi])
  end
       
  def update_params
    params.require(:ruta_turistica).permit(:id, :nom, :temps,
       :pdis_rutaturisticas_attributes => [:ordre, :id, :pdi_attributes => [:id, :nom]]) # si hi poso :ordre en els attributes, em deixa de guardar el pdi id
  end

end
