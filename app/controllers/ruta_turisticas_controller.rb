class RutaTuristicasController < ApplicationController
  def new
    if usuari_actual.nil?
      redirect_to ruta_turisticas_path, :notice => "Has d'estar registrat per poder crear rutes turístiques."
    else
      @rt = RutaTuristica.new
      2.times { 
        @rt.pdis_rutaturisticas.build
        @rt.pdis_rutaturisticas.last.pdi = Pdi.new
      }
    end
  end

  def create

    @rt = RutaTuristica.new(create_params)
    @rt.usuari = usuari_actual
    @rt.usuari_modificador = usuari_actual

    llista = params[:ruta_turistica][:pdis_rutaturisticas_attributes].values

    # TODO si pdi_seleccionat no existeix com a pdi. proposar-li a l'usuari de crear-lo. i redirigir-lo a la pàgina de pdi_create

    @rt.el_meu_save(llista)
    
    @rt_creada = @rt.id

    # grant badge manualment si rutes == 3 pq a /badge_rules.rb no funciona
    if @rt.usuari.ruta_turisticas.count == 3
      usuari_actual.add_badge(4)
    end
    
    # TODO, si salva pq la llista no està buida, anar a create correctament. Sino anar a no creada
    
  end

  def show
    @rt = RutaTuristica.find(params[:id])
    @valoracions = @rt.valoracios
    @fotos = []
    @rt.pdis_rutaturisticas.each do |prt|
      if !prt.pdi.fotos_grans.nil?
        fotos_array = prt.pdi.fotos_grans.split ","
        @fotos << fotos_array.first
      end
    end

  end

  def index
    @rts = RutaTuristica.all.order("punts desc")
  end

  def edit
    @rt = RutaTuristica.find(params[:id])
    # TODO check if user have the quest for it in usuari-questionari

    if usuari_actual.nil?
      error = "Has d'estar registrat per poder editar la ruta turística."
      redirect_to ruta_turisticas_path, :notice => error

    elsif @rt.usuari != usuari_actual
      uq = UsuariQuestionari.where(:questionari_id => @rt.questionari.id, :usuari_id => usuari_actual.id)
      if !uq.exists?
        redirect_to :controller => 'usuari_questionaris', :action => 'new', :questionari_id => @rt.questionari.id
      else
        nota = uq.first.nota_treta
        if nota < 5.0
          error = "El qüestionari per aquesta ruta turística no ha estat superat, per tant no pots editar-la."
          redirect_to ruta_turisticas_path, :notice => error
        end
      end
    end


  end

  def update
    @rt = RutaTuristica.find(params[:id])
    @rt.usuari_modificador = usuari_actual
    #cont = 0
    #@rt.pdis_rutaturisticas.each do |association|
      #association.update_attributes(:ordre =>  params[:ruta_turistica][:pdis_rutaturisticas_attributes].values[cont][:ordre], :pdi_id => params[:ruta_turistica][:pdis_rutaturisticas_attributes].values[cont][:pdi_attributes][:id])
      #cont = cont + 1
    # end
    @rt.update(update_params)

    # TODO mirar si se n'han tret o afegit. crear o treure instàncies a pdis_rutaturist
    llista = params[:ruta_turistica][:pdis_rutaturisticas_attributes].values
    
    @rt.pdis_rutaturisticas.destroy_all
    
    @rt.el_meu_save(llista)
    

  end
  
  def create_params
    params.require(:ruta_turistica).permit(:nom, :temps,
       :pdis_rutaturistica_attributes => [:pdi])
  end
       
  def update_params
    params.require(:ruta_turistica).permit(:id, :nom, :temps,
       :pdis_rutaturisticas_attributes => [:ordre, :id, :pdi_attributes => [:id, :nom]]) # si hi poso :ordre en els attributes, em deixa de guardar el pdi id
  #params.require(:ruta_turistica).permit(:id, :nom, :temps,
   #    :pdis_rutaturistica_attributes => [:pdi, :pdi_attributes]) # si hi poso :ordre en els attributes, em deixa de guardar el pdi id
  end

end
