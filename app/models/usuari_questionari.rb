class UsuariQuestionari < ActiveRecord::Base
	belongs_to :questionari
	belongs_to :usuari
end
