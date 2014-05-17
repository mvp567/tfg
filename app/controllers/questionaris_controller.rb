class QuestionarisController < ApplicationController
def new
		@exam = Questionari.new

    	2.times { 
      		@exam.preguntas.build
      		#@exam.pdis_rutaturisticas.last.pdi = Pdi.new
      		2.times { 
      			@exam.preguntas.last.respostas.build
      		 }
    	}
	end

	def create
		
		@exam = Questionari.new(create_params)
    	@exam.usuari = usuari_actual
    	llista_preguntes = []
    	preguntes = params[:questionari][:preguntas_attributes]
    	preguntes.each do |preg|

    		p = Pregunta.new(:text => preg.second[:text])

			llista_respostes = []
    		respostes = preg.second[:respostas_attributes]
    		respostes.each do |resp|
    			llista_respostes << Resposta.new(:text => resp.second[:text], :correcta => resp.second[:correcta])

    		end
    		p.respostas = llista_respostes

    		llista_preguntes << p
    		
    	end
    	@exam.preguntas = llista_preguntes

    	@exam.save
	end

	def show
	end

	def create_params
    	params.require(:questionari).permit(:text, :preguntas_attributes => [:text, :respostas_attributes => [:text, :correcta]])
  end
end
