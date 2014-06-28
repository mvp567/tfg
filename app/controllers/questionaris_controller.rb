class QuestionarisController < ApplicationController
def new
		@quest = Questionari.new

    	2.times { 
      		preg = @quest.preguntas.build
      		2.times { 
            preg.respostas.build
      		 }
    	}
	end

	def create
		@quest = Questionari.new(create_params)
    	@quest.usuari = usuari_actual

        # guardant paràmetres del pas 1
        if params[:param_reputacio] == "1"
            @quest.param_reputacio = 0
        elsif params[:param_reputacio] == "2"
            @quest.param_reputacio = 200
        elsif params[:param_reputacio] == "3"
            @quest.param_reputacio = 400
        elsif params[:param_reputacio] == "4"
            @quest.param_reputacio = 600
        elsif params[:param_reputacio] == "5"
            @quest.param_reputacio = 800
        end

        if params[:param_pais] == "2"
            @quest.param_pais_naixament = true 
            @quest.param_pais_residencia = true
        elsif params[:param_pais] == "3"
            @quest.param_pais_naixament = true   
        elsif params[:param_pais] == "4"
            @quest.param_pais_residencia = true
        end

        # guardant preguntes i repsostes del pas 2
    	llista_preguntes = []
    	preguntes = params[:questionari][:preguntas_attributes]
    	preguntes.each do |preg|
                if !preg.second[:text].blank?
        		  p = Pregunta.new(:text => preg.second[:text])
                

        			llista_respostes = []
            		respostes = preg.second[:respostas_attributes]
            		respostes.each do |resp|
                        if !resp.second[:text].blank?
            			  llista_respostes << Resposta.new(:text => resp.second[:text], :correcta => resp.second[:correcta])
                        end
            		end
                    if llista_respostes.count > 0
            		  p.respostas = llista_respostes
                      llista_preguntes << p
                      #else
                        #TODO donar error que les respostes no poden ser buides, de fet mínim 2
                    end
                else
                    @quest.preguntas.destroy_all
                    
                end

    	end
        if llista_preguntes.count > 0
    	   @quest.preguntas = llista_preguntes
        #else
            #TODO donar error que la llista de preguntes no pot ser buida
        end
        @quest.ruta_turistica = RutaTuristica.find_by_id(params[:questionari][:ruta_turistica_id].to_i)
    	@quest.save
	end

	def show
	end

	def create_params
    	params.require(:questionari).permit(:text, :preguntas_attributes => [:text, :respostas_attributes => [:text, :correcta]])
    end
end
