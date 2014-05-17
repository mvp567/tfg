class Questionari < ActiveRecord::Base
	belongs_to :ruta_turistica
	belongs_to :usuari
	has_many :usuari_questionaris
	has_many :usuaris, through: :usuari_questionaris
	has_many :preguntas, :dependent => :destroy

	accepts_nested_attributes_for :preguntas

end
