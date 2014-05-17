class Pregunta < ActiveRecord::Base
	belongs_to :questionari
	has_many :respostas

	accepts_nested_attributes_for :respostas
end
