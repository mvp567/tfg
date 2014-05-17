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
    	llista_preguntes = []
    	preguntes = params[:questionari][:preguntas_attributes]
    	preguntes.each do |preg|
            if !preg.second[:text].blank?
    		  p = Pregunta.new(:text => preg.second[:text])
            end

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
    	end
        if llista_preguntes.count > 0
    	   @quest.preguntas = llista_preguntes
        #else
            #TODO donar error que la llista de preguntes no pot ser buida
        end

    	@quest.save
	end

	def show
	end

	def create_params
    	params.require(:questionari).permit(:text, :preguntas_attributes => [:text, :respostas_attributes => [:text, :correcta]])
    end
end
