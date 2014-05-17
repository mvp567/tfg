class UsuariQuestionarisController < ApplicationController
  
  def new
  	byebug
  	@uq = UsuariQuestionari.new
  	@uq.questionari = Questionari.find(params[:questionari_id]) 

  	# TODO passar params[:questionari_id] per params get desde l'edit de la ruta
  end

  def create
  	#calcular nota i guardar-la a @uq.nota
  	#llista_preguntes = params[:usuari_questionari][:questionari_attributes][:preguntas_attributes]
  	#llista_respostes = params[:usuari_questionari][:questionari_attributes][:preguntas_attributes][:respostas_attributes]
  	byebug

  	quest_id = params[:usuari_questionari][:questionari_attributes][:id]
    
    @uq = UsuariQuestionari.new
    @uq.usuari = usuari_actual
    @uq.questionari = Questionari.find_by_id(quest_id)

    #@uq.save
  end

  def create_params
    	params.require(:usuari_questionari).permit(:questionari_id, 
    		:questionari_attributes => [:questionari_id, :preguntas_attributes => [:respostas_attributes]])
  end

end
