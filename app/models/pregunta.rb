class Pregunta < ActiveRecord::Base
	belongs_to :test_to_pass
	has_many :respostas

	accepts_nested_attributes_for :respostas
end
