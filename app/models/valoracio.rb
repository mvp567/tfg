class Valoracio < ActiveRecord::Base
	belongs_to :ruta_turistica
	belongs_to :pdi
	belongs_to :usuari
end
