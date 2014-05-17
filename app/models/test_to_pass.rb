class TestToPass < ActiveRecord::Base
	belongs_to :ruta_turistica
	belongs_to :usuari
	has_many :usuari_tests
	has_many :usuaris, through: :usuari_tests
	has_many :preguntas

	accepts_nested_attributes_for :preguntas
end
