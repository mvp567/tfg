class UsuariQuestionarisController < ApplicationController
  
  def new
  	@uq = UsuariQuestionari.new
  	@uq.questionari = Questionari.find(params[:questionari_id])

    # comprovar si usuari_editor compleix paràmetres base
    @passa_parametres = false
    cond1 = cond2 = cond3 = true
    
    # 1) comprovar param_reputació
     if @uq.questionari.param_reputacio > usuari_actual.points
      cond1 = false
     end

    # 2) comprovar param_país_naixament
     if @uq.questionari.param_pais_naixament == true
        cond2 = false
        pdis_rts = @uq.questionari.ruta_turistica.pdis_rutaturisticas
        pdis_rts.each do |pdi_rt|
          pdi = pdi_rt.pdi
          if usuari_actual.pais == pdi.pais
            cond2 = true
          end
        end
      end
    
    # 3) comprovar param_país_residència
      if @uq.questionari.param_pais_residencia == true
        cond3 = false
        pdis_rts = @uq.questionari.ruta_turistica.pdis_rutaturisticas
        pdis_rts.each do |pdi_rt|
          pdi = pdi_rt.pdi
          usuari_actual.pais_residencias.each do |pr|
            if pr.pais.nom == pdi.pais
              cond3 = true
            end
          end
        end
      end

      # si els dos paràmetres del qüestionari estan a true, vol dir que qualsevol dels dos serveix
      if @uq.questionari.param_pais_naixament == true && @uq.questionari.param_pais_residencia == true
        if cond1 && (cond2 || cond3)
          @passa_parametres = true
        end
      else
        if cond1 && cond2 && cond3
          @passa_parametres = true
        end
      end
    

    # si no hi ha preguntes, posar un 10 al quest
    if @passa_parametres && @uq.questionari.preguntas.count.zero?
      @uq.usuari = usuari_actual
      @uq.nota_treta = 10
      @uq.save
      redirect_to edit_ruta_turistica_path(@uq.questionari.ruta_turistica)
    end
  end

  def create

    # calcular nota
  	llista_preguntes = params[:usuari_questionari][:questionari_attributes][:preguntas_attributes]

    llista_contestacions = []
  	params["contestacions"].each do |contestacio|
      la_pregunta = contestacio.first
      resposta_contestada = contestacio.second
      llista_contestacions << resposta_contestada
    end

    index = 0
    num_resp_correctes = 0
    llista_preguntes.each do |pr|
      llista_respostes = pr.second["respostas_attributes"]
      llista_respostes.each do |re|
        if re.second["correcta"] == "t"
          if re.second["id"] == llista_contestacions[index]
            num_resp_correctes = num_resp_correctes + 1
          end
        end
      end
      index = index +1
    end
    nota = (num_resp_correctes.to_f / index.to_f) * 10
    

  	quest_id = params[:usuari_questionari][:questionari_attributes][:id]
    
    @uq = UsuariQuestionari.new
    @uq.usuari = usuari_actual
    @uq.questionari = Questionari.find_by_id(quest_id)
    @uq.nota_treta = nota
    @uq.save
  end

  def create_params
    	params.require(:usuari_questionari).permit(:questionari_id, 
    		:questionari_attributes => [:questionari_id, :preguntas_attributes => [:respostas_attributes]])
  end

end
