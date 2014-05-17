class UsuariQuestionari < ActiveRecord::Base
	belongs_to :questionari
	belongs_to :usuari

	accepts_nested_attributes_for :questionari
end
