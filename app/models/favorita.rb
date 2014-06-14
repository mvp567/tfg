class Favorita < ActiveRecord::Base
	belongs_to :ruta_turistica
	belongs_to :usuari
end
